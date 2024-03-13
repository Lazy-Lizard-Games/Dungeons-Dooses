class_name KnockbackBientiyAction
extends BientityAction

## Knocks back the target for a duration after applying any actor bonuses then target bonuses.

@export var strength: Number = ConstantNumber.new()
@export var duration: Number = ConstantNumber.new()
@export var direction: Vector = ConstantVector.new()

func execute(actor: Entity, target: Entity, scale: float=1) -> void:
  # Apply actor knockback strength affinity
  var strength_multiple := MultiplyNumber.new()
  strength_multiple.x = strength
  var strength_multiplier := ConstantNumber.new()
  strength_multiplier.constant = actor.generics.get_generic(Enums.GenericType.KnockbackStrengthAffinity).get_final_value() * scale
  strength_multiple.y = strength_multiplier
  # Apply actor knockback duration affinity
  var duration_multiple := MultiplyNumber.new()
  duration_multiple.x = duration
  var duration_multiplier := ConstantNumber.new()
  duration_multiplier.constant = actor.generics.get_generic(Enums.GenericType.KnockbackDurationAffinity).get_final_value() * scale
  duration_multiple.y = duration_multiplier
  # Apply target bonuses then knockback
  var knockback = KnockbackEntityAction.new()
  knockback.strength = strength_multiple
  knockback.duration = duration_multiple
  knockback.direction = direction
  knockback.execute(target, scale)
