extends EntityAction
class_name AddEntityAction

## Adds an entity action to the entity.

## Type of entity action to add.
@export var type: Enums.EntityActionType
## Action to add.
@export var action: EntityAction


func execute(entity: Entity, _scale := 1.0) -> void:
	match type:
		Enums.EntityActionType.OnDied:
			entity.action_component.actions_on_died.append(action)
		Enums.EntityActionType.OnKill:
			entity.action_component.actions_on_kill.append(action)
