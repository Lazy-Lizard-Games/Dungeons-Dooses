extends BientityCondition
class_name TargetBientityCondition

## Checks an entity condition against the target.

## Condition to check aginst the target.
@export var condition: EntityCondition


func execute(_actor, target) -> bool:
	return condition.execute(target)
