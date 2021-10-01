// This is an Unreal Script

class X2StrategyElement_HeistPointsOfInterest extends X2StrategyElement_DefaultPointsOfInterest

// Create template items and return that to fill-out the information in this POI.
static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreatePOIGamescomTemplate());

	return Templates;
}

static function X2DataTemplate CreatePOIGamescomTemplate()
{
	local X2PointOfInterestTemplate Template;

	`CREATE_X2POINTOFINTEREST_TEMPLATE(Template, 'POI_Gamescom');

	Template.CanAppearFn = CanGamescomPOIAppear;

	return Template;
}
function bool CanGamescomPOIAppear(XComGameState_PointOfInterest POIState)
{
	return false;
}