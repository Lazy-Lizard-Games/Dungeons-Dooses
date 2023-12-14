extends Node2D
class_name Effect

signal expired

@export var id: String
@export_multiline var description: String
@export var icon: ImageTexture
@export var max_stacks: int = 1
@export var duration: float
var parent: EffectComponent

## Effect instantiation logic
func start(_parent: EffectComponent) -> void:
	parent = _parent
	if duration > 0:
		var timer = Timer.new()
		add_child(timer)
		timer.timeout.connect(func(): expired.emit())
		timer.start(duration)
	enter()

## Effect construction logic
func enter() -> void:
	pass

## Effect deconstruction logic
func exit() -> void:
	pass
