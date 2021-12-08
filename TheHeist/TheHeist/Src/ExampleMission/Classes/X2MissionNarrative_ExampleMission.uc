// This is an Unreal Script

class X2MissionNarrative_ExampleMission extends X2MissionNarrative;

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2MissionNarrativeTemplate> Templates;

    Templates.AddItem(AddDefaultRecoverWepNarrativeTemplate());

    return Templates;
}

static function X2MissionNarrativeTemplate AddDefaultRecoverWepNarrativeTemplate()
{
    local X2MissionNarrativeTemplate Template;

    `CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultRecover_Wep');

    Template.MissionType = "Recover_Wep";
    Template.NarrativeMoments[0]="EX_BombDisposalContent.VO.BombDisposal_PlaceholderChirp"; //Tactical Intro
	Template.NarrativeMoments[1]="EX_BombDisposalContent.VO.BombDisposal_PlaceholderChirp"; //Bomb Spotted
	Template.NarrativeMoments[2]="EX_BombDisposalContent.VO.BombDisposal_PlaceholderChirp"; //Bomb Disarmed
	Template.NarrativeMoments[3]="EX_BombDisposalContent.VO.BombDisposal_PlaceholderChirp"; //Timer Nag Three
	Template.NarrativeMoments[4]="EX_BombDisposalContent.VO.BombDisposal_PlaceholderChirp"; //Timer Nag Last
	Template.NarrativeMoments[5]="EX_BombDisposalContent.VO.BombDisposal_PlaceholderChirp"; //Timer Expired
	Template.NarrativeMoments[6]="EX_BombDisposalContent.VO.BombDisposal_PlaceholderChirp"; //Proceed To Sweep
	Template.NarrativeMoments[7]="EX_BombDisposalContent.VO.BombDisposal_PlaceholderChirp"; //Map Cleared Bomb Active
	Template.NarrativeMoments[8]="EX_BombDisposalContent.VO.BombDisposal_PlaceholderChirp"; //Mission Completed
	Template.NarrativeMoments[9]="EX_BombDisposalContent.VO.BombDisposal_PlaceholderChirp"; //Mission Failed
	Template.NarrativeMoments[10]="EX_BombDisposalContent.VO.BombDisposal_PlaceholderChirp"; //Bomb accidentally blown up

    return Template;
}