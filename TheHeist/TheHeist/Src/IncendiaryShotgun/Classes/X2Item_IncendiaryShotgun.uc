class X2Item_IncendiaryShotgun extends X2Item config(IncendiaryShotgun);

var config array<int> FLAMESHOT_RANGE;

var config WeaponDamageValue FLAMESHOT_BASEDAMAGE;
var config int FLAMESHOT_AIM;
var config int FLAMESHOT_CRITCHANCE;
var config int FLAMESHOT_ICLIPSIZE;
var config int FLAMESHOT_ISOUNDRANGE;
var config int FLAMESHOT_IENVIRONMENTDAMAGE;
var config int FLAMESHOT_SUPPLIES;
var config int FLAMESHOT_TRADINGPOSTVALUE;
var config int FLAMESHOT_POINTS;
var config int FLAMESHOT_IUPGRADESLOTS;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> MyWeapons;
	MyWeapons.AddItem(CreateTemplate_IncendiaryShotgun());

	return MyWeapons;
}

static function X2DataTemplate CreateTemplate_IncendiaryShotgun()
{
	local X2WeaponTemplate Template;
	`CREATE_X2TEMPLATE(class 'X2WeaponTemplate', Template, 'FlameShot');

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'shotgun';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.ConvShotgun.ConvShotgun_Base";
	Template.Tier = 0;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_CONVENTIONAL_RANGE;

	Template.BaseDamage = default.FLAMESHOT_BASEDAMAGE;
	Template.Aim = default.FLAMESHOT_AIM;
	Template.CritChance = default.FLAMESHOT_CRITCHANCE;
	Template.iClipSize = default.FLAMESHOT_ICLIPSIZE;
	Template.iSoundRange = default.FLAMESHOT_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.FLAMESHOT_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = default.FLAMESHOT_IUPGRADESLOTS;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;

	Template.Abilities.AddItem('StandardShot');	
	Template.Abilities.AddItem('Overwatch');	
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('RapidFire');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.GameArchetype = "WP_Shotgun_CV.WP_Shotgun_CV";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Shotgun';
	Template.AddDefaultAttachment('Foregrip', "ConvShotgun.Meshes.SM_ConvShotgun_ForegripA" /*FORGRIP INCLUDED IN MAG IMAGE*/);
	Template.AddDefaultAttachment('Mag', "ConvShotgun.Meshes.SM_ConvShotgun_MagA", , "img:///UILibrary_Common.ConvShotgun.ConvShotgun_MagA");
	Template.AddDefaultAttachment('Reargrip', "ConvShotgun.Meshes.SM_ConvShotgun_ReargripA" /*REARGRIP IS INCLUDED IN THE TRIGGER IMAGE*/);
	Template.AddDefaultAttachment('Stock', "ConvShotgun.Meshes.SM_ConvShotgun_StockA", , "img:///UILibrary_Common.ConvShotgun.ConvShotgun_StockA");
	Template.AddDefaultAttachment('Trigger', "ConvShotgun.Meshes.SM_ConvShotgun_TriggerA", , "img:///UILibrary_Common.ConvShotgun.ConvShotgun_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");

	Template.iPhysicsImpulse = 2;
	Template.StartingItem = true;
	Template.CanBeBuilt = true;

	Template.fKnockbackDamageAmount = 5.0f;
	Template.fKnockbackDamageRadius = 0.0f;

	return Template;
}