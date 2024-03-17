class_name DamageBientityOverTime
extends BientityAction

## Applies a damage over time to the target after applying bonuses

## Base amount of damage to deal every tick.
@export var amount: Number
## Time in seconds until the damage over time ends.
@export var duration: Number
## Time in seconds between damage ticks.
@export var interval: Number
## Type of the dealt damage.
@export var type: Enums.DamageType

func execute(actor: Entity, target: Entity, scale:=1.0) -> void:
  ## Prepare final amount
  var final_amount = MultiplyNumber.new()
  final_amount.x = amount
  final_amount.y = ConstantNumber.new(actor.affinities.get_affinity(Enums.AffinityType.Damage, type).get_final_value())
  ## Prepare final duration
  var final_duration = MultiplyNumber.new()
  final_duration.x = duration
  final_duration.y = ConstantNumber.new(actor.affinities.get_affinity(Enums.AffinityType.Duration, type).get_final_value())
  ## Prepare entity damage over time
  var damage_entity_over_time = DamageEntityOverTime.new()
  damage_entity_over_time.amount = final_amount
  damage_entity_over_time.duration = final_duration
  damage_entity_over_time.interval = interval
  damage_entity_over_time.type = type
  damage_entity_over_time.execute(target, scale)