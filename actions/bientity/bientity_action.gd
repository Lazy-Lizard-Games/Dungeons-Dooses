extends Resource
class_name BientityAction

## Optional condition to check the pair against.
@export var condition: BientityCondition


## Executes an action on the Pair<Entity, Entity>
func execute(_actor: Entity, _target: Entity) -> void:
	pass
