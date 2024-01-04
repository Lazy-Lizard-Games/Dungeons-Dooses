extends Resource
class_name ResistanceAttributes

@export_category("Damage Resistances")
@export var normal_damage: Attribute
@export var fire_damage: Attribute
@export var frost_damage: Attribute
@export var shock_damage: Attribute
@export var poison_damage: Attribute

@export_category("Duration Resistances")
@export var normal_duration: Attribute
@export var fire_duration: Attribute
@export var frost_duration: Attribute
@export var shock_duration: Attribute
@export var poison_duration: Attribute


func get_damage_resistance(type: Enums.DamageType) -> Attribute:
	match type:
		Enums.DamageType.Normal:
			return normal_damage
		Enums.DamageType.Fire:
			return fire_damage
		Enums.DamageType.Frost:
			return frost_damage
		Enums.DamageType.Shock:
			return shock_damage
		Enums.DamageType.Poison:
			return poison_damage
		_:
			return null


func get_duration_resistance(type: Enums.DamageType) -> Attribute:
	match type:
		Enums.DamageType.Normal:
			return normal_duration
		Enums.DamageType.Fire:
			return fire_duration
		Enums.DamageType.Frost:
			return frost_duration
		Enums.DamageType.Shock:
			return shock_duration
		Enums.DamageType.Poison:
			return poison_duration
		_:
			return null
