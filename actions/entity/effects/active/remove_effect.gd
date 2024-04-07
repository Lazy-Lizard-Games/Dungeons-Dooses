class_name RemoveActiveEffect
extends EntityAction

## Removes a active effect from an entity.

## The unique identifier of the active effect to remove.
@export var uid: StringName

func execute(entity: Entity, _scale:=1.0) -> void:
	entity.effect_component.remove_active_effect(uid)