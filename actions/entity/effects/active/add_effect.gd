class_name AddActiveEffect
extends EntityAction

## Adds an active effect to the entity.

## Packed scene of the active effect to add.
@export var effect_scene: PackedScene

func execute(entity: Entity, _scale:=1.0) -> void:
	var effect = effect_scene.instantiate() as ActiveEffect
	effect.init(entity)
	entity.effect_component.add_active_effect(effect)