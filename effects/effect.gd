extends Node2D
class_name Effect

signal expired

@export var id: String
@export_multiline var description: String
@export var icon: ImageTexture
@export var max_stacks: int = 1
@export var duration: float
var parent: EffectComponent
var current_stacks: int = 1
var expire_timer: Timer

## Effect instantiation logic
func start(_parent: EffectComponent) -> void:
	parent = _parent
	if duration > 0:
		expire_timer = Timer.new()
		add_child(expire_timer)
		expire_timer.timeout.connect(func(): expired.emit())
		expire_timer.start(duration)
	enter()

## Effect construction logic
func enter() -> void:
	pass

## Effect deconstruction logic
func exit() -> void:
	pass

## Logic to handle adding stacks
func add_stack() -> void:
	if current_stacks < max_stacks:
		current_stacks += 1

## Logic to handle removing stacks
func remove_stack() -> void:
	if current_stacks > 0:
		current_stacks -= 1
