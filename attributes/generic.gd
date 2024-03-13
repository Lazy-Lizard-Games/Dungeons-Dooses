extends Resource
class_name GenericAttributes

@export var health_max = Attribute.new(100, 1, 0, pow(2, 31) - 1)
@export var health_regeneration = Attribute.new(5, 1, 0, pow(2, 31) - 1)
@export var stamina_max = Attribute.new(100, 1, 0, pow(2, 31) - 1)
@export var stamina_regeneration = Attribute.new(5, 1, 0, pow(2, 31) - 1)
@export var movement_speed = Attribute.new(250, 1, 0, pow(2, 31) - 1)
@export var acceleration = Attribute.new(50, 1, 0, pow(2, 31) - 1)
@export var friction = Attribute.new(0.45, 1, 0, pow(2, 31) - 1)
@export var cast_cost = Attribute.new(1, 1, 0, pow(2, 31) - 1)
@export var cast_time = Attribute.new(1, 1, 0, pow(2, 31) - 1)
@export var recharge_time = Attribute.new(1, 1, 0, pow(2, 31) - 1)
@export var knockback_strength_affinity = Attribute.new(1, 1, 0, pow(2, 31) - 1)
@export var knockback_strength_resistance = Attribute.new(1, 1, 0, pow(2, 31) - 1)
@export var knockback_duration_affinity = Attribute.new(1, 1, 0, pow(2, 31) - 1)
@export var knockback_duration_resistance = Attribute.new(1, 1, 0, pow(2, 31) - 1)

func get_generic(type: Enums.GenericType) -> Attribute:
	match type:
		Enums.GenericType.HealthMax:
			return health_max
		Enums.GenericType.HealthRegeneration:
			return health_regeneration
		Enums.GenericType.StaminaMax:
			return stamina_max
		Enums.GenericType.StaminaRegeneration:
			return stamina_regeneration
		Enums.GenericType.MovementSpeed:
			return movement_speed
		Enums.GenericType.Acceleration:
			return acceleration
		Enums.GenericType.CastCost:
			return cast_cost
		Enums.GenericType.CastTime:
			return cast_time
		Enums.GenericType.RechargeTime:
			return recharge_time
		Enums.GenericType.KnockbackStrengthAffinity:
			return knockback_strength_affinity
		Enums.GenericType.KnockbackStrengthResistance:
			return knockback_strength_resistance
		Enums.GenericType.KnockbackDurationAffinity:
			return knockback_duration_affinity
		Enums.GenericType.KnockbackDurationResistance:
			return knockback_duration_resistance
		Enums.GenericType.Friction:
			return friction
		_:
			return null

func add_modifier(type: Enums.GenericType, modifier: AttributeModifier) -> void:
	var generic = get_generic(type)
	if generic:
		generic.add_modifier(modifier)

func remove_modifier(type: Enums.GenericType, uid: String) -> void:
	var generic = get_generic(type)
	if generic:
		generic.remove_modifier(uid)
