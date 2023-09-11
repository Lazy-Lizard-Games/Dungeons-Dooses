extends Effect

# Blood stacks used as the main identity if the
# berserker tree. Dealing damage if you have
# skills into either of the tier 1 skills will
# give you a stack of blood up to the maximum
@export var decay_amount: int = 2
@export var attack_speed: float = 0.05
@export var stack_duration: float = 1.0
@onready var expire_timer = $ExpireTimer


func _ready() -> void:
	stack_changed.connect(on_stack_changed)


func _add_stack() -> void:
	var previous_stacks = stacks
	stacks = min(stacks + 1, effect_instance.max_stacks)
	stack_changed.emit(stacks - previous_stacks)
	expire_timer.start(stack_duration)


func _remove_stack() -> void:
	var previous_stacks = stacks
	stacks = max(0, stacks - decay_amount)
	stack_changed.emit(stacks - previous_stacks)
	if stacks == 0:
		exit_tree()


func on_stack_changed(change: int) -> void:
	container.stats_component.attack_speed_mult += attack_speed*change


func _on_expire_timer_timeout():
	if stacks > 0:
		_remove_stack()
	if stacks == 0:
		expire_timer.stop()
