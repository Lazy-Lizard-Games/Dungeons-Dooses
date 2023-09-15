extends Effect

# Blood stacks used as the main identity if the
# berserker tree. Dealing damage if you have
# skills into either of the tier 1 skills will
# give you a stack of blood up to the maximum
@export var decay_rate: int = 2
@onready var idle_timer = $IdleTimer
@onready var decay_timer = $DecayTimer


func _add_stack() -> void:
	var previous_stacks = stacks
	stacks = min(stacks + 1, effect_instance.max_stacks)
	stack_changed.emit(stacks - previous_stacks)
	idle_timer.start(effect_instance.duration)
	decay_timer.stop()


func _remove_stack() -> void:
	var previous_stacks = stacks
	stacks = max(0, stacks - 1)
	stack_changed.emit(stacks - previous_stacks)
	if stacks == 0:
		exit_tree()


func _on_idle_timer_timeout():
	decay_timer.start(1/decay_rate)


func _on_decay_timer_timeout():
	_remove_stack()
