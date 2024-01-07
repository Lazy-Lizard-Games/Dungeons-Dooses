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
	Ring,
	Necklace,
	Circlet,
	Charm,
	Consumable,
}

var equipment = [ItemType.Charm, ItemType.Circlet, ItemType.Ring, ItemType.Necklace]

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
	Normal, 
	Fire, 
	Frost, 
	Shock,
	Poison, 
}

enum GenericType
{
	HealthMax,
	HealthRegeneration,
	MovementSpeed,
	AttackSpeed,
	AttackDamage,
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

