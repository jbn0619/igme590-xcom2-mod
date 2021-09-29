class X2Item_ExampleMission extends X2Item;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;

	// Bomb Disposal
	Items.AddItem(CreateQuestItemEX_BombDisposal());
	
	return Items;
}

static function X2DataTemplate CreateQuestItemEX_BombDisposal()
{
	local X2QuestItemTemplate Item;

	`CREATE_X2TEMPLATE(class'X2QuestItemTemplate', Item, 'EX_BombDisposal_EleriumCharge');
	Item.ItemCat = 'quest';

	Item.MissionType.AddItem("EX_BombDisposal");

	Item.RewardType.AddItem('Reward_Intel');
	Item.RewardType.AddItem('Reward_Supplies');
	Item.RewardType.AddItem('Reward_Soldier');
	Item.RewardType.AddItem('Reward_Scientist');
	Item.RewardType.AddItem('Reward_Engineer');

	return Item;
}