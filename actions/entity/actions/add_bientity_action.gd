extends EntityAction
class_name AddBientityAction

## Adds a bientity action to the entity.

## Type of bientity action to add.
@export var type: Enums.BientityActionType
## Action to add.
@export var action: BientityAction


func execute(entity: Entity, _scale := 1.0) -> void:
	match type:
		Enums.BientityActionType.OnHit:
			entity.action_component.actions_on_hit.append(action)
		Enums.BientityActionType.OnHurt:
			entity.action_component.actions_on_hurt.append(action)
