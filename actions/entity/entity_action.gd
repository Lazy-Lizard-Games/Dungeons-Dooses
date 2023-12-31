extends Resource
class_name EntityAction

## Condition to check whether action is executed.
@export var condition: EntityCondition

## Takes in an entity and performs some action to it.
func execute(_entity: Entity) -> void:
	return
