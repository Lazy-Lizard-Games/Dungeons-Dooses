extends Resource
class_name EntityAction

## Condition to check whether action is executed.
@export var condition: EntityCondition


## Executes an action on the entity.
func execute(_entity: Entity) -> void:
	pass
