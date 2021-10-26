class X2StrategyElement_WeaponUnlockResearch extends X2StrategyElement_XpackTechs config(WeaponUnlockResearch_Set)

var config int SniperUnlockResearch_Time;
var config int SniperUnlockResearch_Cost;
var config int ShotgunUnlockResearch_Time;
var config int ShotgunUnlockResearch_Cost;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;

	Techs.AddItem(CreateSniperUnlockResearch());
	Techs.AddItem(CreateShotgunUnlockResearch());

	return Techs;
}

// Instantiate the sniper's creation tech as a template.
static function X2DataTemplate CreateSniperUnlockResearch()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	// Setup Template
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'SniperUnlockResearch');
	Template.PointsToComplete = default.SniperUnlockResearch_Time;
	Template.strImage = "img:///UILibrary_XPACK_Common.BT_modreuse";
	Template.ResearchCompletedFn = SniperUnlockResearchCompleted;

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('ModularWeapons');
	//Template.Requirements.bVisibleIfTechsNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'ExperimentalBlueprint';
	Resources.Quantity = default.SniperUnlockResearch_Cost;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

// Instantiate the shotgun's creation tech as a template.
static function X2DataTemplate CreateShotgunUnlockResearch()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	// Setup Template
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'ShotgunUnlockResearch');
	Template.PointsToComplete = default.ShotgunUnlockResearch_Time;
	Template.strImage = "img:///UILibrary_XPACK_Common.BT_pcsreuse";
	Template.ResearchCompletedFn = ShotgunUnlockResearchCompleted;

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('ModularWeapons');
	//Template.Requirements.bVisibleIfTechsNotMet = true;

    // Cost
	Resources.ItemTemplateName = 'ExperimentalBlueprint';
	Resources.Quantity = default.ShotgunUnlockResearch_Cost;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

// Executes after the sniper unlock tech has been completed.
function SniperUnlockResearchCompleted(XComGameState NewGameState, XComGameState_Tech TechState)
{
	local XComGameState_HeadquartersXCom XComHQ;

	XComHQ = GetNewXComHQState(NewGameState);
	// Unlock stuff.
}

// Executes after the shotgun unlock tech has been completed.
function ShotgunUnlockResearchCompleted(XComGameState NewGameState, XComGameState_Tech TechState)
{
	local XComGameState_HeadquartersXCom XComHQ;

	XComHQ = GetNewXComHQState(NewGameState);
	// Unlock stuff.
}