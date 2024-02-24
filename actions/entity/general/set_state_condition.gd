extends EntityAction
class_name SetStateConditionEntityAction

## Sets the state of the condition to true or false for the entities animation tree.

## Condition to set
@export var condition_path: String
## State to set condition to
@export var state: bool


func execute(entity: Entity, _scale := 1.0) -> void:
	print_debug(condition_path in entity.animation_tree)
	if condition_path in entity.animation_tree:
		print_debug(entity.animation_tree[condition_path])
		entity.animation_tree[condition_path] = state
