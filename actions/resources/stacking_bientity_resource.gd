extends Resource
class_name StackingBientityResource

## A stacking resource that affects a bientity pair.

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
@export var actions_per_stack: Array[StackingBientityAction]
## Actions to be executed on minimum stacks.
@export var actions_on_min_stacks: Array[BientityAction]
## Actions to be executed on maximum stacks.
@export var actions_on_max_stacks: Array[BientityAction]
## Current value of stacking resource.
var stacks: int = 1
var decay_timer: Timer

var bientity_actor: Entity
var actor_copy: Entity
var bientity_target: Entity
var target_copy: Entity


func start(actor: Entity, target: Entity) -> void:
	bientity_actor = actor
	bientity_target = target
	actor_copy = Entity.new()
	actor_copy.affinities = bientity_actor.affinities
	actor_copy.resistances = bientity_actor.resistances
	actor_copy.generics = bientity_actor.generics
	target_copy = Entity.new()
	target_copy.affinities = bientity_target.affinities
	target_copy.resistances = bientity_target.resistances
	target_copy.generics = bientity_target.generics
	stacks = starting_stacks
	for action in actions_per_stack:
		action = action.duplicate(true)
		action.execute(bientity_actor, bientity_target)
		action.update_stacks(stacks)
		stack_changed.connect(action.update_stacks)
		ended.connect(
			func():
				if !bientity_actor: bientity_actor = actor_copy
				if !bientity_target: bientity_target = target_copy
				action.reverse(bientity_actor, bientity_target)
		)
	min_stacks_reached.connect(
		func():
			for action in actions_on_min_stacks:
				if !bientity_actor: bientity_actor = actor_copy
				if !bientity_target: bientity_target = target_copy
				action.execute(bientity_actor, bientity_target)
	)
	max_stacks_reached.connect(
		func():
			for action in actions_on_max_stacks:
				if !bientity_actor: bientity_actor = actor_copy
				if !bientity_target: bientity_target = target_copy
				action.execute(bientity_actor, bientity_target)
	)
	if decay_interval > 0:
		decay_timer = Timer.new()
		decay_timer.autostart = true
		decay_timer.timeout.connect(
			func():
				remove_stack(decay_amount)
		)
		bientity_target.add_child(decay_timer)
		decay_timer.start(decay_interval)


func end(_actor: Entity, target: Entity) -> void:
	ended.emit()
	if decay_timer:
		target.remove_child(decay_timer)


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
