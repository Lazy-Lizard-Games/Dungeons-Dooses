extends Resource
class_name ResistanceAttributes

@export var normal_resistance: Attribute
@export var fire_resistance: Attribute
@export var frost_resistance: Attribute
@export var shock_resistance: Attribute
@export var poison_resistance: Attribute


func get_resistance(type: Enums.DamageType) -> Attribute:
	match type:
		Enums.DamageType.Normal:
			return normal_resistance
		Enums.DamageType.Fire:
			return fire_resistance
		Enums.DamageType.Frost:
			return frost_resistance
		Enums.DamageType.Shock:
			return shock_resistance
		Enums.DamageType.Poison:
			return poison_resistance
		_:
			return null
