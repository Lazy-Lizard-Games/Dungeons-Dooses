extends BientityAction
class_name DamageOverTime

## Deals damage to the target entity at regular intervals for a set duration.

@export var type: Enums.DamageType
@export var amount: float
@export var duration: float
@export var interval: float


func execute(actor: Entity, target: Entity) -> void:
	if condition:
		if !condition.execute(actor, target):
			return
	var temp_duration = duration
	## Apply actor affinity bonuses.
	var affinities = actor.affinities
	var duration_affinity = affinities.get_duration_affinity(type)
	if duration_affinity:
		temp_duration += temp_duration * duration_affinity.get_final_value()
	## Apply target resistance bonuses.
	var resistances = target.resistances
	var duration_resistance = resistances.get_duration_resistance(type)
	if duration_resistance:
		temp_duration -= temp_duration * duration_resistance.get_final_value()
	## Setup damage action.
	var damage_action = DamageAction.new()
	damage_action.amount = amount
	damage_action.type = type
	damage_action.execute(actor, target)
	## Start interval timer.
	var interval_timer = Timer.new()
	interval_timer.timeout.connect(
		func():
			damage_action.execute(actor, target)
			interval_timer.start(interval)
	)
	target.add_child(interval_timer)
	interval_timer.start(interval)
	## Start duration timer.
	var duration_timer = Timer.new()
	duration_timer.timeout.connect(
		func():
			target.remove_child(interval_timer)
			target.remove_child(duration_timer)
	)
	target.add_child(duration_timer)
	duration_timer.start(temp_duration)
