extends Resource
class_name EffectInstance

@export var effect_scene: PackedScene
@export var max_stacks: int = 1
@export_range(0, 1) var chance: float = 1
@export var duration: float = 0
@export var decay_rate: float = 2


func get_description(stacks: int) -> String:
	if not effect_scene or stacks > max_stacks or stacks == 0:
		return ""
	var effect: Effect = effect_scene.instantiate()
	effect.stacks = stacks
	var desc = effect.get_description()
	effect.queue_free()
	return desc
