extends EntityAction
class_name SetStateConditionEntityAction

## Sets the state of the condition to true or false for the entities animation tree.

## Condition to set
@export var condition_path: String
## State to set condition to
@export var state: bool

func execute(entity: Entity, _scale:=1.0) -> void:
	if condition_path in entity.animation_tree:
		entity.animation_tree[condition_path] = state
