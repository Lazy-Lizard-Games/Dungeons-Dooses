class_name AddDamageEffectWithTransforms
extends BientityAction

## Adds a damage effect to the target after applying actor transforms.

## Packed scene of the damage effect to add.
@export var effect_scene: PackedScene

func execute(actor: Entity, target: Entity, _scale:=1.0) -> void:
	var effect = effect_scene.instantiate() as DamageEffect
	effect.apply_actor_transforms(actor)
	effect.init(target)
	target.effect_component.add_damage_effect(effect)