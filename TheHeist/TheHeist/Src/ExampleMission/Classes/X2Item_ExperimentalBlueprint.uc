// CREDIT TO https://github.com/WOTCStrategyOverhaul/CovertInfiltration/blob/master/CovertInfiltration/Src/CovertInfiltration/Classes/X2Item_InfiltrationResources.uc
// FOR EXAMPLE CODE

class X2Item_ExperimentalBlueprint extends X2Item;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Resources;

	Resources.AddItem(CreateExperimentalBlueprint());
	
	return Resources;
}

static function X2DataTemplate CreateExperimentalBlueprint()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'TEMP_ExperimentalBlueprint');

	Template.strImage = "";
	Template.ItemCat = 'resource';
	Template.CanBeBuilt = false;
	Template.HideInInventory = false;

	return Template;
}