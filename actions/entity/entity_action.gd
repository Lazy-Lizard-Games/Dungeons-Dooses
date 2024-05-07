extends BaseAction
class_name EntityAction

## Condition to check whether action is executed.
@export var condition: EntityCondition

var executed := false


## Executes an action on the entity.
func execute(_entity: Entity, _scale := 1.0) -> void:
	pass


## Reverses an action on the entity.
func reverse(_entity: Entity) -> void:
	pass
