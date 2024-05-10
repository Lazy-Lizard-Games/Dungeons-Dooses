extends Node

enum InteractionType
{
	Pickup,
	Open,
	Use,
}

enum InventoryType
{
	Player,
	Chest,
	Sack,
	Crate,
}

enum ItemType
{
	Item,
	Consumable,
	Equipment,
}

enum EquipmentType
{
	Ring,
	Necklace,
	Circlet,
	Charm,
}

enum FactionType
{
	None,
	Player,
	Human,
	Beast,
	Monster,
}

enum DamageType
{
	Slash,
	Pierce,
	Blunt,
	Fire,
	Frost,
	Shock,
	Poison,
	True,
}

enum GenericType
{
	HealthMax,
	HealthRegeneration,
	StaminaMax,
	StaminaRegeneration,
	MovementSpeed,
	Acceleration,
	Friction,
	AbilityPower,
	AbilityRange,
	AbilityDuration,
	AbilityEfficiency,
	CastRate,
	ChargeRate,
	RefreshRate,
	KnockbackStrengthAffinity,
	KnockbackStrengthResistance,
	KnockbackDurationAffinity,
	KnockbackDurationResistance,
}

enum OperationType
{
	Addition,
	Multiplication,
	Set,
}

enum AffinityType
{
	Damage,
	Duration,
}

enum ResistanceType
{
	Damage,
	Duration,
}

enum EntityActionType
{
	OnKill,
	OnDied,
}

enum BientityActionType
{
	OnHurt,
	OnHit,
}

enum ItemActionType
{
	OnConsume,
	OnEquip,
}

enum AbilityType
{
	Primary,
	Secondary,
	Support,
	Passive,
	Dash,
	Special,
}
