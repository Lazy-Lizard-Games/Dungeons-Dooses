extends Resource
class_name StackingResource

signal ended
signal stack_changed(stacks: int)
signal min_stacks_reached
signal max_stacks_reached

## Identifying name of stacking resource.
@export var name: String
## Description of stacking resource.
@export_multiline var description: String
## Icon of stacking resource.
@export var icon: Image
## Minimum value of stacking resource.
@export var min_stacks: int
## Maximum value of stacking resource.
@export var max_stacks: int
## Starting stacks of stacking resource when first added.
@export var starting_stacks: int
## Interval at which stacks will decay, zero means no decay.
@export var decay_interval: float
## Amount of stacks lost per decay interval.
@export var decay_amount: int = 1
## Actions to be executed that will scale with stacks.
@export var actions_per_stack: Array[StackingEntityAction] 
## Actions to be executed on minimum stacks.
@export var actions_on_min_stacks: Array[EntityAction]
## Actions to be executed on maximum stacks.
@export var actions_on_max_stacks: Array[EntityAction]
## Current value of stacking resource.
var stacks: int = 1
var decay_timer: Timer

func start(entity: Entity) -> void:
	stacks = starting_stacks
	for action in actions_per_stack:
		action = action.duplicate(true)
		action.execute(entity)
		action.update_stacks(stacks)
		stack_changed.connect(action.update_stacks)
		ended.connect(
			func():
				action.reverse(entity)
		)
	min_stacks_reached.connect(
		func():
			for action in actions_on_min_stacks:
				action.execute(entity)
	)
	max_stacks_reached.connect(
		func():
			for action in actions_on_max_stacks:
				action.execute(entity)
	)
	if decay_interval > 0:
		decay_timer = Timer.new()
		decay_timer.autostart = true
		decay_timer.timeout.connect(
			func():
				remove_stack(decay_amount)
		)
		entity.add_child(decay_timer)
		decay_timer.start(decay_interval)


func end(entity: Entity) -> void:
	ended.emit()
	if decay_timer:
		entity.remove_child(decay_timer)


func add_stack(amount: int = 1) -> void:
	if decay_timer:
		decay_timer.start(decay_interval)
	if stacks < max_stacks:
		stacks = min(max_stacks, stacks + amount)
		stack_changed.emit(stacks)
		if stacks == max_stacks:
			max_stacks_reached.emit()


func remove_stack(amount: int = 1) -> void:
	if stacks > min_stacks:
		stacks = max(min_stacks, stacks - amount)
		stack_changed.emit(stacks)
		if stacks == min_stacks:
			min_stacks_reached.emit()
