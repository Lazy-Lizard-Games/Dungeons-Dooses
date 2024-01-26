extends Resource
class_name AffinityAttributes

@export_category("Damage Affinities")
@export var normal_damage = Attribute.new(0, 1, -1, pow(2, 31)-1)
@export var fire_damage = Attribute.new(0, 1, -1, pow(2, 31)-1)
@export var frost_damage = Attribute.new(0, 1, -1, pow(2, 31)-1)
@export var shock_damage = Attribute.new(0, 1, -1, pow(2, 31)-1)
@export var poison_damage = Attribute.new(0, 1, -1, pow(2, 31)-1)

@export_category("Duration Affinities")
@export var normal_duration = Attribute.new(0, 1, -1, pow(2, 31)-1)
@export var fire_duration = Attribute.new(0, 1, -1, pow(2, 31)-1)
@export var frost_duration = Attribute.new(0, 1, -1, pow(2, 31)-1)
@export var shock_duration = Attribute.new(0, 1, -1, pow(2, 31)-1)
@export var poison_duration = Attribute.new(0, 1, -1, pow(2, 31)-1)


func get_affinity(affinity_type: Enums.AffinityType, damage_type: Enums.DamageType) -> Attribute:
	match affinity_type:
		Enums.AffinityType.Damage:
			return get_damage_affinity(damage_type)
		Enums.AffinityType.Duration:
			return get_duration_affinity(damage_type)
		_:
			return null


func get_damage_affinity(type: Enums.DamageType) -> Attribute:
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


func get_duration_affinity(type: Enums.DamageType) -> Attribute:
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


func add_modifier(affinity_type: Enums.AffinityType, damage_type: Enums.DamageType, modifier: AttributeModifier) -> void:
	var affinity = get_affinity(affinity_type, damage_type)
	if affinity:
		affinity.add_modifier(modifier)


func remove_modifier(affinity_type: Enums.AffinityType, damage_type: Enums.DamageType, uid: String) -> void:
	var affinity = get_affinity(affinity_type, damage_type)
	if affinity:
		affinity.remove_modifier(uid)

