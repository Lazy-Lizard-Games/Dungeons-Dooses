extends BientityCondition
class_name ActorBientityCondition

## Checks an entity condition against the actor.

## Condition to check aginst the actor.
@export var condition: EntityCondition


func execute(actor, _target) -> bool:
	return condition.execute(actor)
