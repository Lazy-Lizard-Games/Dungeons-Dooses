class_name RemoveDamageEffect
extends EntityAction

## Removes a damage effect from an entity.

## The unique identifier of the damage effect to remove.
@export var uid: StringName

func execute(entity: Entity, _scale:=1.0) -> void:
	entity.effect_component.remove_effect(uid)