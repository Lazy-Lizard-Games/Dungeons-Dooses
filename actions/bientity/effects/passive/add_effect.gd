class_name AddPassiveEffectWithTransforms
extends BientityAction

## Adds a passive effect to the target after applying actor transforms.

## Packed scene of the passive effect to add.
@export var effect_scene: PackedScene

func execute(actor: Entity, target: Entity, _scale:=1.0) -> void:
	var effect = effect_scene.instantiate() as PassiveEffect
	effect.apply_actor_transforms(actor)
	effect.init(target)
	target.effect_component.add_passive_effect(effect)