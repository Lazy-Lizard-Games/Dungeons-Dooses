class_name KnockbackEntityAction
extends EntityAction

## Knocks back an entity for a duration, after applying target bonuses.

@export var strength: Number = ConstantNumber.new()
@export var duration: Number = ConstantNumber.new()
@export var direction: Vector = ConstantVector.new()

# var knockback_effect = preload ("res://data/effects/statuses/knockback.tres")

const KNOCKBACK_EFFECT_UID: StringName = &"KnockbackEffect"
const KNOCKBACK_EFFECT_VALUE: float = 0.15

func execute(entity: Entity, scale:=1.0) -> void:
  # Apply entity knockback strength resistance
  var strength_multiple := MultiplyNumber.new()
  strength_multiple.x = strength
  var strength_multiplier := ConstantNumber.new()
  strength_multiplier.constant = entity.generics.get_generic(Enums.GenericType.KnockbackStrengthResistance).get_final_value() * scale
  strength_multiple.y = strength_multiplier
  # Apply entity knockback duration resistance
  var duration_multiple := MultiplyNumber.new()
  duration_multiple.x = duration
  var duration_multiplier := ConstantNumber.new()
  duration_multiplier.constant = entity.generics.get_generic(Enums.GenericType.KnockbackDurationResistance).get_final_value() * scale
  duration_multiple.y = duration_multiplier
  # Apply knockback to entity
  entity.velocity_component.set_velocity(direction.get_vector(entity) * strength_multiple.execute() * scale)
  # Apply knockback effect to entity
  var effect_modifier = AttributeModifier.new()
  effect_modifier.uid = KNOCKBACK_EFFECT_UID
  effect_modifier.operation = Enums.OperationType.Multiplication
  effect_modifier.value = KNOCKBACK_EFFECT_VALUE
  var add_effect = AddGenericModifierEntityAction.new()
  add_effect.modifier = effect_modifier
  add_effect.generic_type = Enums.GenericType.Friction
  var remove_effect = RemoveGenericModifierEntityAction.new()
  remove_effect.uid = KNOCKBACK_EFFECT_UID
  remove_effect.generic_type = Enums.GenericType.Friction
  var knockback_effect = CooldownEntity.new()
  knockback_effect.action_on_start = add_effect
  knockback_effect.action_on_end = remove_effect
  knockback_effect.duration = duration_multiple.execute()
  knockback_effect.execute(entity, scale)
  