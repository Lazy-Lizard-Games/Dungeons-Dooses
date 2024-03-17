class_name DamageEntityOverTime
extends EntityAction

## Applies a damage over time to the entity after applying resistances.

## Base amount of damage to deal every tick.
@export var amount: Number
## Time in seconds until the damage over time ends.
@export var duration: Number
## Time in seconds between damage ticks.
@export var interval: Number
## Type of the dealt damage.
@export var type: Enums.DamageType

func execute(entity: Entity, _scale:=1.0) -> void:
  if condition:
    if !condition.execute(entity):
      return
  if "health_component" in entity:
    ## Prepare final amount
    var final_amount = MultiplyNumber.new()
    final_amount.x = amount
    final_amount.y = ConstantNumber.new(entity.affinities.get_affinity(Enums.AffinityType.Damage, type).get_final_value())
    ## Prepare final duration
    var final_duration = MultiplyNumber.new()
    final_duration.x = duration
    final_duration.y = ConstantNumber.new(entity.affinities.get_affinity(Enums.AffinityType.Duration, type).get_final_value())
    ## Apply damage over time
    var interval_timer = Timer.new()
    entity.add_child(interval_timer)
    interval_timer.timeout.connect(
      func():
        var temp=final_amount.execute()
        entity.health_component.damage(type, temp)
        TextHandler.create_damage_over_time_text(type, temp, entity.global_position)
    )
    interval_timer.start(interval.execute())
    var duration_timer = Timer.new()
    entity.add_child(duration_timer)
    duration_timer.timeout.connect(
      func():
        entity.remove_child(interval_timer)
        entity.remove_child(duration_timer)
    )
    duration_timer.start(final_duration.execute())
