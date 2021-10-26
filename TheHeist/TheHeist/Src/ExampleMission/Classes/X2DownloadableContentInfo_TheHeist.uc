// CREDIT TO https://github.com/WOTCStrategyOverhaul/CovertInfiltration/blob/6c760eb670866137d1a636c615ec3cb8ad5f0a0f/CovertInfiltration/Src/CovertInfiltration/Classes/X2DownloadableContentInfo_CovertInfiltration.uc#L284-L311
// FOR THIS SCRIPT

// This script is to update an already-started save file with our mod's content. There are various hooks and other stuffs in here to help set that up.

// Loaded/new game
static event InstallNewCampaign(XComGameState StartState)
{
	CreateExperimentalBlueprintState(StartState);
}

static event OnLoadedSavedGame()
{
	CreateExperimentalBlueprintState(none);
}

static protected function CreateExperimentalBlueprintState (XComGameState NewGameState)
{
	local XComGameState_HeadquartersXCom XComHQ;
	local X2ItemTemplateManager ItemTemplateMgr;
	local XComGameState_Item NewItemState;
	local X2ItemTemplate ItemTemplate;
	local bool bSubmitLocally;

	ItemTemplateMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemTemplate = ItemTemplateMgr.FindItemTemplate('ExperimentalBlueprint');

	if (NewGameState == none)
	{
		NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("CI: Creating Actionable Leads resource state");
		bSubmitLocally = true;
	}

	NewItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	NewItemState.Quantity = 0;

	XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', `XCOMHQ.ObjectID));
	XComHQ.AddItemToHQInventory(NewItemState);

	if (bSubmitLocally)
	{
		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	}
}
