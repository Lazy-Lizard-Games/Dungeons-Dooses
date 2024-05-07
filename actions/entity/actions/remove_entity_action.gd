extends EntityAction
class_name RemoveEntityAction

## Removes an entity action from the entity.

## Type of entity action to remove.
@export var type: Enums.EntityActionType
## Name of entity action to remove.
@export var id: String


func execute(entity: Entity, _scale: = 1.0) -> void:
	var actions: Array[EntityAction]
	match type:
		Enums.EntityActionType.OnDied:
			actions = entity.action_component.actions_on_died
		Enums.EntityActionType.OnKill:
			actions = entity.action_component.actions_on_kill
	if actions:
		for action in actions:
			if action._id == id:
				action.reverse(entity)
				actions.erase(action)
				break
