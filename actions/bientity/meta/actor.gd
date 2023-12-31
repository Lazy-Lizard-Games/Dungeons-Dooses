extends BientityAction
class_name ActorAction

## Executes an entity action on the actor.

## Entity action to execute on the actor.
@export var entity_action: EntityAction

func execute(actor: Entity, target: Entity) -> void:
	if condition:
		if !condition.execute(actor, target):
			return
	entity_action.execute(actor)
