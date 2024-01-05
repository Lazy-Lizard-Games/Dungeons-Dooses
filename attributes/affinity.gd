extends Resource
class_name AffinityAttributes

@export_category("Damage Affinities")
@export var normal_damage: Attribute
@export var fire_damage: Attribute
@export var frost_damage: Attribute
@export var shock_damage: Attribute
@export var poison_damage: Attribute

@export_category("Duration Affinities")
@export var normal_duration: Attribute
@export var fire_duration: Attribute
@export var frost_duration: Attribute
@export var shock_duration: Attribute
@export var poison_duration: Attribute


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


func modify_damage(type: Enums.DamageType, modifier: AttributeModifier, is_add := true) -> void:
	var damage = get_damage_affinity(type)
	if !damage:
		return
	if is_add:
		damage.add_modifier(modifier)
	else:
		damage.remove_modifier(modifier)


func modify_duration(type: Enums.DamageType, modifier: AttributeModifier, is_add := true) -> void:
	var duration = get_duration_affinity(type)
	if !duration:
		return
	if is_add:
		duration.add_modifier(modifier)
	else:
		duration.remove_modifier(modifier)
