// This is an Unreal Script

class X2MissionSet_ExampleMission extends X2MissionSet config(GameCore);

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2MissionTemplate> Templates;

    Templates.AddItem(AddMissionTemplate('EX_BombDisposal'));

    return Templates;
}
