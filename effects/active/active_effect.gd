class_name ActiveEffect
extends PassiveEffect

## Active effects are often applied via damage, or similar, and have a duration before expiring.

## Duration of the effect.
@export var duration_time: float
var duration_timer: Timer

func _ready():
	duration_timer = Timer.new()
	add_child(duration_timer)
	duration_timer.timeout.connect(on_duration_timout)
	duration_timer.start(duration_time)
	super()

func add_stack() -> void:
	var temp_prev = stacks
	if stacks == max_stacks:
		duration_timer.start(duration_time)
	else:
		stacks += 1
	stacks_changed.emit(temp_prev, stacks)

func apply_actor_transforms(actor: Entity) -> void:
	duration_time *= actor.generics.ability_duration.get_final_value()

func on_duration_timout() -> void:
	var temp = stacks
	stacks -= 1
	stacks_changed.emit(temp, stacks)
	if stacks == 0:
		exit()
		expired.emit()