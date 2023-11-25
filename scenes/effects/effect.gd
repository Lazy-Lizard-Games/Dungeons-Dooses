extends Node2D
class_name Effect

signal exited_tree(effect: Effect)
signal stack_changed(change: int)

var effect_instance: EffectInstance
var stacks: int = 0

@onready var idle_timer: Timer = Timer.new()
@onready var decay_timer: Timer = Timer.new()


## Overwritten by children
func init() -> void:
	pass


func _ready() -> void:
	idle_timer.one_shot = true
	idle_timer.timeout.connect(_on_idle_timer_timeout)
	add_child(idle_timer)
	decay_timer.one_shot = false
	decay_timer.timeout.connect(_on_decay_timer_timeout)
	add_child(decay_timer)
	add_stack()
	init()


func add_stack() -> void:
	if stacks < effect_instance.max_stacks:
		stacks += 1
	stack_changed.emit(1)
	idle_timer.start(effect_instance.duration)
	decay_timer.stop()


func remove_stack() -> void:
	stacks = max(0, stacks-1)
	stack_changed.emit(-1)
	if stacks == 0:
		exit_tree()


func get_description() -> String:
	return ""


func clear_effect() -> void:
	pass


func _on_idle_timer_timeout() -> void:
	decay_timer.start(1/effect_instance.decay_rate)


func _on_decay_timer_timeout() -> void:
	remove_stack()


func exit_tree() -> void:
	clear_effect()
	exited_tree.emit(self)
