extends Node2D
class_name Effect

signal exited_tree(effect: Effect)
signal stack_changed(change: int)

var effect_instance: EffectInstance
var container: EffectComponent
var stacks: int = 0
var idle_timer: Timer
var decay_timer: Timer


func _ready():
	idle_timer = Timer.new()
	idle_timer.one_shot = true
	idle_timer.timeout.connect(_on_idle_timer_timeout)
	
	decay_timer = Timer.new()
	decay_timer.one_shot = false
	decay_timer.timeout.connect(_on_decay_timer_timeout)


func _add_stack() -> void:
	if stacks < effect_instance.max_stacks:
		stacks += 1
	stack_changed.emit(1)
	
	idle_timer.start(effect_instance.duration)
	decay_timer.stop()


func _remove_stack() -> void:
	stacks = max(0, stacks-1)
	stack_changed.emit(-1)
	if stacks == 0:
		exit_tree()


func _get_description() -> String:
	return ""


func _clear_effect() -> void:
	pass


func _on_idle_timer_timeout() -> void:
	decay_timer.start(1/effect_instance.decay_rate)


func _on_decay_timer_timeout() -> void:
	_remove_stack()


func exit_tree() -> void:
	_clear_effect()
	exited_tree.emit(self)
