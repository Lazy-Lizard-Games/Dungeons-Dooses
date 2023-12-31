extends Resource
class_name GenericAttributes

@export var health_max: Attribute
@export var health_regeneration: Attribute
@export var movement_speed: Attribute
@export var movement_acceleration: Attribute
@export var attack_speed: Attribute
@export var attack_damage: Attribute


func get_generic(type: Enums.GenericType) -> Attribute:
	match type:
		Enums.GenericType.HealthMax:
			return health_max
		Enums.GenericType.HealthRegeneration:
			return health_regeneration
		Enums.GenericType.MovementSpeed:
			return movement_speed
		Enums.GenericType.MovementAcceleration:
			return movement_acceleration
		Enums.GenericType.AttackSpeed:
			return attack_speed
		Enums.GenericType.AttackDamage:
			return attack_damage
		_:
			return null


func modify_generic(type: Enums.GenericType, modifier: AttributeModifier) -> void:
	var generic = get_generic(type)
	if !generic:
		return
	generic.add_modifier(modifier)
