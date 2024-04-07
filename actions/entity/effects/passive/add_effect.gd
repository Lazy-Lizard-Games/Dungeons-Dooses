class_name AddPassiveEffect
extends EntityAction

## Adds a passive effect to the entity.

## Packed scene of the passive effect to add.
@export var effect_scene: PackedScene

func execute(entity: Entity, _scale:=1.0) -> void:
	var effect = effect_scene.instantiate() as PassiveEffect
	effect.init(entity)
	entity.effect_component.add_passive_effect(effect)