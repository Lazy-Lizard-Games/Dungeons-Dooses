extends BaseAction
class_name BientityAction

## Optional condition to check the pair against.
@export var condition: BientityCondition

var executed := false


## Executes an action on the Pair<Entity, Entity>
func execute(_actor: Entity, _target: Entity, _scale := 1.0) -> void:
	pass


## Reverses an action on the entity.
func reverse(_actor: Entity, _target: Entity) -> void:
	pass
