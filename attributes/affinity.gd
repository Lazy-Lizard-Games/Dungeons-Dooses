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


func add_affinity_modifiers(affinites: AffinityAttributes) -> void:
	normal_damage.modifiers += affinites.normal_damage.modifiers
	fire_damage.modifiers += affinites.fire_damage.modifiers
	frost_damage.modifiers += affinites.frost_damage.modifiers
	shock_damage.modifiers += affinites.shock_damage.modifiers
	poison_damage.modifiers += affinites.poison_damage.modifiers
	normal_duration.modifiers += affinites.normal_duration.modifiers
	fire_duration.modifiers += affinites.fire_duration.modifiers
	frost_duration.modifiers += affinites.frost_duration.modifiers
	shock_duration.modifiers += affinites.shock_duration.modifiers
	poison_duration.modifiers += affinites.poison_duration.modifiers
