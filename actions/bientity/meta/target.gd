extends BientityAction
class_name TargetAction

## Executes an entity action on the target.

## Entity action to execute on the target.
@export var entity_action: EntityAction

func execute(actor: Entity, target: Entity) -> void:
	if condition:
		if !condition.execute(actor, target):
			return
	entity_action.execute(target)
