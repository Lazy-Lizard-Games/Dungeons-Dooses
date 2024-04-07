class_name RemovePassiveEffect
extends EntityAction

## Removes a passive effect from an entity.

## The unique identifier of the passive effect to remove.
@export var uid: StringName

func execute(entity: Entity, _scale:=1.0) -> void:
	entity.effect_component.remove_effect(uid)