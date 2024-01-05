extends Resource
class_name GenericAttributes

@export var health_max = Attribute.new(100, 1, 0, pow(2, 31)-1)
@export var health_regeneration = Attribute.new(5, 1, 0, pow(2, 31)-1)
@export var movement_speed = Attribute.new(250, 1, 0, pow(2, 31)-1)
@export var attack_speed = Attribute.new(0, 1, -1, pow(2, 31)-1)
@export var attack_damage = Attribute.new(0, 1, -1, pow(2, 31)-1)


func get_generic(type: Enums.GenericType) -> Attribute:
	match type:
		Enums.GenericType.HealthMax:
			return health_max
		Enums.GenericType.HealthRegeneration:
			return health_regeneration
		Enums.GenericType.MovementSpeed:
			return movement_speed
		Enums.GenericType.AttackSpeed:
			return attack_speed
		Enums.GenericType.AttackDamage:
			return attack_damage
		_:
			return null


func modify_generic(type: Enums.GenericType, modifier: AttributeModifier, is_add := true) -> void:
	var generic = get_generic(type)
	if !generic:
		return
	if is_add:
		generic.add_modifier(modifier)
	else:
		generic.remove_modifier(modifier)
