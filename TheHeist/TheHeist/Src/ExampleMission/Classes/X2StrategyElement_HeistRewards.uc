class X2StrategyElement_HeistRewards extends X2StrategyElement_DefaultRewards;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Rewards;

	// Resource Rewards
	Rewards.AddItem(CreateExperimentalBlueprintRewardTemplate());

	return Rewards;
}

static function X2DataTemplate CreateExperimentalBlueprintRewardTemplate()
{
	local X2RewardTemplate Template;

	`CREATE_X2Reward_TEMPLATE(Template, 'Reward_ExperimentalBlueprint');
	Template.rewardObjectTemplateName = 'ExperimentalBlueprint';
	Template.RewardImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Supplies";

	Template.GenerateRewardFn = GenerateExperimentalBlueprintReward;
	Template.SetRewardFn = SetResourceReward;
	Template.GiveRewardFn = GiveResourceReward;
	Template.GetRewardStringFn = GetResourceRewardString;
	Template.GetRewardImageFn = GetResourceRewardImage;
	Template.GetRewardIconFn = GetGenericRewardIcon;
	
	return Template;
}

function GenerateExperimentalBlueprintReward(XComGameState_Reward RewardState, XComGameState NewGameState, optional float RewardScalar = 1.0, optional StateObjectReference RegionRef)
{
	RewardState.Quantity = 2;

	RewardState.Quantity = Round(RewardScalar * float(RewardState.Quantity));
}