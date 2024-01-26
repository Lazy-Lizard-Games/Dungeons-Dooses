extends Resource
class_name ResistanceAttributes

@export_category("Damage Resistances")
@export var normal_damage = Attribute.new(0, 1, pow(-2, 31), 0.8)
@export var fire_damage = Attribute.new(0, 1, pow(-2, 31), 0.8)
@export var frost_damage = Attribute.new(0, 1, pow(-2, 31), 0.8)
@export var shock_damage = Attribute.new(0, 1, pow(-2, 31), 0.8)
@export var poison_damage = Attribute.new(0, 1, pow(-2, 31), 0.8)

@export_category("Duration Resistances")
@export var normal_duration = Attribute.new(0, 1, pow(-2, 31), 0.8)
@export var fire_duration = Attribute.new(0, 1, pow(-2, 31), 0.8)
@export var frost_duration = Attribute.new(0, 1, pow(-2, 31), 0.8)
@export var shock_duration = Attribute.new(0, 1, pow(-2, 31), 0.8)
@export var poison_duration = Attribute.new(0, 1, pow(-2, 31), 0.8)


func get_resistance(resistance_type: Enums.ResistanceType, damage_type: Enums.DamageType) -> Attribute:
	match resistance_type:
		Enums.ResistanceType.Damage:
			return get_damage_resistance(damage_type)
		Enums.ResistanceType.Duration:
			return get_duration_resistance(damage_type)
		_:
			return null


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


func add_modifier(resistance_type: Enums.ResistanceType, damage_type: Enums.DamageType, modifier: AttributeModifier) -> void:
	var resistance = get_resistance(resistance_type, damage_type)
	if resistance:
		resistance.add_modifier(modifier)


func remove_modifier(resistance_type: Enums.ResistanceType, damage_type: Enums.DamageType, uid: String) -> void:
	var resistance = get_resistance(resistance_type, damage_type)
	if resistance:
		resistance.remove_modifier(uid)
