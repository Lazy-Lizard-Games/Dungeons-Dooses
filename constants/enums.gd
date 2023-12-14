extends Node


## Attribute types for individual indexing
enum AttributeType {
	# General
	Health,
	Stamina,
	Speed,
	Acceleration,
	Friction,
	KnockbackResistance,
	
	# Damage Resistances
	NormalResistance,
	FireResistance,
	FrostResistance,
	ShockResistance,
	PoisonResistance,
	
	# Damage Affinities
	NormalAffinity,
	FireAffinity,
	FrostAffinity,
	ShockAffinity,
	PoisonAffinity,
}

## Attribute groups for collective indexing
enum AttributeGroup {
	Affinity,
	Resistance,
	General,
	Speed
}

enum AttributeBonusType {
	Raw,
	Multiplier
}
