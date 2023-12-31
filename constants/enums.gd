extends Node

enum InteractionType 
{
	Pickup,
	Open,
	Use,
}

enum InventoryType 
{
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
	MovementAcceleration,
	AttackSpeed,
	AttackDamage,
}

enum OperationType
{
	Addition,
	Multiplication,
	Set,
}
