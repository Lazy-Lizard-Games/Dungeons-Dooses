extends Resource
class_name EntityCondition

## Flips the returned value.
@export var invert: bool

## Takes in an entity and checks for some condition.
func execute(_entity: Entity) -> bool:
	return true
