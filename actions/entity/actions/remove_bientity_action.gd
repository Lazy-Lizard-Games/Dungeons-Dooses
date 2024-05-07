extends EntityAction
class_name RemoveBientityAction

## Removes a bientity action from the entity.

## Type of the bientity action to remove.
@export var type: Enums.BientityActionType
## Name of the bientity action to remove.
@export var id: String


func execute(entity: Entity, _scale: = 1.0) -> void:
	var actions: Array[BientityAction]
	match type:
		Enums.BientityActionType.OnHit:
			actions = entity.action_component.actions_on_hit
		Enums.BientityActionType.OnHurt:
			actions = entity.action_component.actions_on_hurt
	if actions:
		for action in actions:
			if action._id == id:
				action.reverse(entity, entity)
				actions.erase(action)
				break
