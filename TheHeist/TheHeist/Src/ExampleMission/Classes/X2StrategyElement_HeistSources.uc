class X2StrategyElement_HeistSources extends X2StrategyElement_DefaultMissionSources;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateHeistMissionSource());

	return Templates;
}

static function X2DataTemplate CreateHeistMissionSource()
{
	local X2MissionSourceTemplate Template;
	local RewardDeckEntry DeckEntry;

	`CREATE_X2TEMPLATE(class'X2MissionSourceTemplate', Template, 'MissionSource_Heist');
	Template.bShowRewardOnPin = true;
	Template.OnSuccessFn = HeistOnSuccess;
	Template.OnFailureFn = HeistOnFailure;
	Template.OnExpireFn = HeistOnExpire;
	Template.DifficultyValue = 1;
	Template.OverworldMeshPath = "UI_3D.Overwold_Final.GorillaOps";
	Template.MissionImage = "img:///UILibrary_StrategyImages.X2StrategyMap.Alert_Guerrilla_Ops";
	Template.GetMissionDifficultyFn = GetMissionDifficultyFromMonth;
	Template.SpawnMissionsFn = SpawnHeistMissions;
	Template.MissionPopupFn = GuerillaOpsPopup;
	Template.WasMissionSuccessfulFn = StrategyObjectivePlusSweepCompleted;

	DeckEntry.RewardName = 'Reward_ExperimentalBlueprint';
	DeckEntry.Quantity = 1;
	Template.RewardDeck.AddItem(DeckEntry);

	return Template;
}

function HeistOnSuccess(XComGameState NewGameState, XComGameState_MissionSite MissionState)
{
	GiveRewards(NewGameState, MissionState);
	SpawnPointOfInterest(NewGameState, MissionState);
	CleanUpHeists(NewGameState, MissionState.ObjectID);
	class'XComGameState_HeadquartersResistance'.static.RecordResistanceActivity(NewGameState, 'ResAct_GuerrillaOpsCompleted');
}

function HeistOnFailure(XComGameState NewGameState, XComGameState_MissionSite MissionState)
{
	local XComGameState_BattleData BattleData;

	BattleData = XComGameState_BattleData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
	
	CleanUpHeists(NewGameState, MissionState.ObjectID);
	class'XComGameState_HeadquartersResistance'.static.DeactivatePOI(NewGameState, MissionState.POIToSpawn);
	class'XComGameState_HeadquartersResistance'.static.RecordResistanceActivity(NewGameState, 'ResAct_GuerrillaOpsFailed');
}

function HeistOnExpire(XComGameState NewGameState, XComGameState_MissionSite MissionState)
{
	class'XComGameState_HeadquartersResistance'.static.DeactivatePOI(NewGameState, MissionState.POIToSpawn);
}

function CleanUpHeists(XComGameState NewGameState, int CurrentMissionID)
{
	local XComGameStateHistory History;
	local XComGameState_MissionSite MissionState;
	local array<int> CleanedUpMissionIDs;


	foreach NewGameState.IterateByClassType(class'XComGameState_MissionSite', MissionState)
	{
		if(MissionState.Source == 'MissionSource_Heist' && MissionState.Available)
		{
			if(MissionState.ObjectID != CurrentMissionID)
			{
				class'XComGameState_HeadquartersResistance'.static.DeactivatePOI(NewGameState, MissionState.POIToSpawn);
			}

			CleanedUpMissionIDs.AddItem(MissionState.ObjectID);
			MissionState.RemoveEntity(NewGameState);
		}
	}

	History = `XCOMHISTORY;

	foreach History.IterateByClassType(class'XComGameState_MissionSite', MissionState)
	{
		if(MissionState.Source == 'MissionSource_Heist' && MissionState.Available && CleanedUpMissionIDs.Find(MissionState.ObjectID) == INDEX_NONE)
		{
			if(MissionState.ObjectID != CurrentMissionID)
			{
				class'XComGameState_HeadquartersResistance'.static.DeactivatePOI(NewGameState, MissionState.POIToSpawn);
			}

			CleanedUpMissionIDs.AddItem(MissionState.ObjectID);
			MissionState.RemoveEntity(NewGameState);
		}
	}

	`XEVENTMGR.TriggerEvent('HeistComplete', , , NewGameState);
}

function SpawnHeistMissions(XComGameState NewGameState, int MissionMonthIndex)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_HeadquartersResistance ResHQ;
	local XComGameState_MissionSite MissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward RewardState;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local X2MissionSourceTemplate MissionSource;
	local array<XComGameState_Reward> MissionRewards;
	local array<StateObjectReference> AvoidRegions, ExcludeRegions, FacilityRegions, DarkEvents;
	local StateObjectReference POIToSpawn;
	local float MissionDuration;
	local int NumOps, idx, RandIndex;
	local array<name> ExcludeList;
	local MissionMonthDifficulty Difficulty;
	local XComGameState_MissionCalendar CalendarState;

	CalendarState = GetMissionCalendar(NewGameState);

	// Set Popup flag
	CalendarState.MissionPopupSources.AddItem('MissionSource_Heist');

	// Calculate Mission Expiration timer (same for each op)
	MissionDuration = float((default.MissionMinDuration + `SYNC_RAND(default.MissionMaxDuration - default.MissionMinDuration + 1)) * 3600);

	// Clear AvoidRegions, ExcludeRegions (avoids compile warning)
	AvoidRegions.Length = 0;
	ExcludeRegions.Length = 0;

	// Exclude Golden Path Mission Regions
	AvoidRegions = GetGoldenPathMissionRegions();

	// Exclude Alien Facility Regions
	FacilityRegions = GetAlienFacilityMissionRegions();
	for(idx = 0; idx < FacilityRegions.Length; idx++)
	{
		AvoidRegions.AddItem(FacilityRegions[idx]);
	}

	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	NumOps = 1;

	// Grab Mission Difficulties
	Difficulty = GetGuerillOpDifficulty();

	History = `XCOMHISTORY;
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	DarkEvents = AlienHQ.ChosenDarkEvents;

	ResHQ = class'UIUtilities_Strategy'.static.GetResistanceHQ();
	POIToSpawn = ResHQ.ChoosePOI(NewGameState); // Choose a random POI to be spawned if the mission is successful

	for(idx = 0; idx < NumOps; idx++)
	{
		RegionState = GetGuerillaOpRegion(ExcludeRegions, AvoidRegions);
		MissionRewards.Length = 0;
		RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate(SelectGuerillaOpRewardType(ExcludeList, CalendarState)));
		RewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
		NewGameState.AddStateObject(RewardState);
		RewardState.GenerateReward(NewGameState, , RegionState.GetReference());
		MissionRewards.AddItem(RewardState);

		MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_Heist'));
		MissionState = XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite'));
		NewGameState.AddStateObject(MissionState);
		MissionState.ManualDifficultySetting = Difficulty.Difficulties[idx % Difficulty.Difficulties.Length];

		MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards, true, true, , MissionDuration);

		// All of the GOps options will spawn the same POI if successful
		MissionState.POIToSpawn = POIToSpawn;
	}

	CalendarState.CreatedMissionSources.AddItem('MissionSource_Heist');
}