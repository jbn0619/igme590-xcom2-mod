class X2Item_ExampleMission extends X2Item;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;

	Items.AddItem(CreateQuestItemExperimentalBlueprint());
	
	return Items;
}

static function X2DataTemplate CreateQuestItemExperimentalBlueprint()
{
	local X2QuestItemTemplate Item;

	`CREATE_X2TEMPLATE(class'X2QuestItemTemplate', Item, 'ExperimentalBlueprint');
	Item.strImage = "";
	Item.ItemCat = 'resource';
	Item.CanBeBuilt = false;
	Item.HideInInventory = false;

	Item.MissionType.AddItem("Recover_Wep");

	Item.RewardType.AddItem('Reward_ExperimentalBlueprint');

	return Item;
}