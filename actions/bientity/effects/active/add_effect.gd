class_name AddActiveEffectWithTransforms
extends BientityAction

## Adds an active effect to the target after applying actor transforms.

## Packed scene of the active effect to add.
@export var effect_scene: PackedScene

func _init(effect_scene_in: PackedScene=null):
	effect_scene = effect_scene_in

func execute(actor: Entity, target: Entity, _scale:=1.0) -> void:
	var effect = effect_scene.instantiate() as ActiveEffect
	effect.apply_actor_transforms(actor)
	effect.init(target)
	target.effect_component.add_active_effect(effect)
