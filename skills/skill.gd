extends Resource
class_name Skill

@export var name: String
@export_multiline var description: String
@export var max_stacks: int

var current_stacks = 0

## Attempts to purchase an amount of stacks in the skill and returns the result.
func purchase(_entity: Entity) -> bool:
	if current_stacks >= max_stacks:
		return false
	current_stacks += 1
	# Do something to the entity based on the current number of stacks, etc.
	return true

## Resets current stack to zero and removes the stacking resource from the entity.
func refund(_entity: Entity) -> void:
	current_stacks = 0
	# Revert what was done to the entity from previous purchases.
