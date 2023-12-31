extends Resource
class_name AffinityAttributes

@export var normal_affinity: Attribute
@export var fire_affinity: Attribute
@export var frost_affinity: Attribute
@export var shock_affinity: Attribute
@export var poison_affinity: Attribute


func get_affinity(type: Enums.DamageType) -> Attribute:
	match type:
		Enums.DamageType.Normal:
			return normal_affinity
		Enums.DamageType.Fire:
			return fire_affinity
		Enums.DamageType.Frost:
			return frost_affinity
		Enums.DamageType.Shock:
			return shock_affinity
		Enums.DamageType.Poison:
			return poison_affinity
		_:
			return null
