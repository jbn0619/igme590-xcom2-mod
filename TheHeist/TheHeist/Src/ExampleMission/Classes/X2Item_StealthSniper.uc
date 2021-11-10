class X2Item_StealthSniper extends X2Item config(StealthSniper);

var config WeaponDamageValue STEALTHSNIPER_BASEDAMAGE;

var config array<int> STEALTHSNIPER_RANGE;

var config int STEALTHSNIPER_AIM;
var config int STEALTHSNIPER_CRITCHANCE;
var config int STEALTHSNIPER_ICLIPSIZE;
var config int STEALTHSNIPER_ISOUNDRANGE;
var config int STEALTHSNIPER_IENVIRONMENTDAMAGE;
var config int STEALTHSNIPER_ISUPPLIES;
var config int STEALTHSNIPER_TRADINGPOSTVALUE;
var config int STEALTHSNIPER_IPOINTS;

var config int STEALTHSNIPER_IUPGRADESLOTS;
var config int STEALTHSNIPER_IACTIONCOST;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> MyWeapons;
	MyWeapons.AddItem(CreateTemplate_StealthSniper());
	return MyWeapons;
}

static function X2DataTemplate CreateTemplate_StealthSniper()
{
	local X2WeaponTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'StealthSniper');
	Template.WeaponPanelImage = "_ConventionalSniperRifle";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sniper_rifle';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.ConvSniper.ConvSniper_Base";
	Template.EquipSound = "Conventional_Weapon_Equip";
	Template.Tier = 0;

	Template.BaseDamage = default.STEALTHSNIPER_BASEDAMAGE;
	Template.RangeAccuracy = default.STEALTHSNIPER_RANGE;
	Template.Aim = default.STEALTHSNIPER_AIM;
	Template.CritChance = default.STEALTHSNIPER_CRITCHANCE;
	Template.iClipSize = default.STEALTHSNIPER_ICLIPSIZE;
	Template.iSoundRange = default.STEALTHSNIPER_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.STEALTHSNIPER_IENVIRONMENTDAMAGE;
	
	Template.NumUpgradeSlots = default.STEALTHSNIPER_IUPGRADESLOTS;
	Template.iTypicalActionCost = default.STEALTHSNIPER_IACTIONCOST;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('SniperStandardFire');
	Template.Abilities.AddItem('SniperRifleOverwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.Abilities.AddItem('RapidFire');
	Template.Abilities.AddItem('Shadowstrike');
	Template.Abilities.AddItem('Stealth');
	Template.Abilities.AddItem('Stealth');
	Template.Abilities.AddItem('Stealth');

	Template.GameArchetype = "WP_SniperRifle_CV.WP_SniperRifle_CV";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';
	Template.AddDefaultAttachment('Mag', "ConvSniper.Meshes.SM_ConvSniper_MagA", , "img:///UILibrary_Common.ConvSniper.ConvSniper_MagA");
	Template.AddDefaultAttachment('Optic', "ConvSniper.Meshes.SM_ConvSniper_OpticA", , "img:///UILibrary_Common.ConvSniper.ConvSniper_OpticA");
	Template.AddDefaultAttachment('Reargrip', "ConvSniper.Meshes.SM_ConvSniper_ReargripA" /*REARGRIP INCLUDED IN TRIGGER IMAGE*/);
	Template.AddDefaultAttachment('Stock', "ConvSniper.Meshes.SM_ConvSniper_StockA", , "img:///UILibrary_Common.ConvSniper.ConvSniper_StockA");
	Template.AddDefaultAttachment('Suppressor', "ConvSniper.Meshes.SM_ConvSniper_SuppressorA", , "img:///UILibrary_Common.ConvSniper.ConvSniper_SuppressorA");
	Template.AddDefaultAttachment('Trigger', "ConvSniper.Meshes.SM_ConvSniper_TriggerA", , "img:///UILibrary_Common.ConvSniper.ConvSniper_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	return Template;
}