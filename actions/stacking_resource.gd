extends Resource
class_name StackingResource

signal min_stacks_reached
signal max_stacks_reached

## Identifying name of stacking resource.
@export var name: String
## Minimum value of stacking resource.
@export var min_stacks: int
## Maximum value of stacking resource.
@export var max_stacks: int
## Starting stacks of stacking resource when first added.
@export var starting_stacks: int
## Action to be executed on minimum stacks.
@export var action_on_min_stacks: EntityAction
## Action to be executed on maximum stacks.
@export var action_on_max_stacks: EntityAction
## Current value of stacking resource.
var stacks: int = 1


func start(entity: Entity) -> void:
	stacks = starting_stacks
	min_stacks_reached.connect(
		func():
			if action_on_min_stacks:
				action_on_min_stacks.execute(entity)
	)
	max_stacks_reached.connect(
		func():
			if action_on_max_stacks:
				action_on_max_stacks.execute(entity)
	)


func end(entity: Entity) -> void:
	entity.action_component.resources.erase(self)


func add_stack(amount: int = 1) -> void:
	if stacks < max_stacks:
		stacks = min(max_stacks, stacks + amount)
		if stacks == max_stacks:
			max_stacks_reached.emit()


func remove_stack(amount: int = 1) -> void:
	if stacks > min_stacks:
		stacks = max(min_stacks, stacks - amount)
		if stacks == min_stacks:
			min_stacks_reached.emit()
