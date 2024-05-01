class_name Effect
extends Resource

## Describes the generic properties of an effect.

signal stacks_changed(old: int, current: int)
signal expired

## Unique identifier for the effect.
@export var name: StringName
## Duration of the effect.
@export var duration_time: float
## Maximum stacks of the effect.
@export var max_stacks: int
## Increment this every frame that the effect is processed.
var duration_timer: float
## Current stacks of the effect.
var stacks: int

## Initialise the effect by connecting it to the effect component or something else.
func init(_effect_component: EffectComponent) -> void:
	pass

## Called when the effect begins processing.
func enter() -> void:
	pass

## Called when the effect stops processing.
func exit() -> void:
	pass

## Called every frame while processing.
func process_frame(_delta) -> void:
	pass

## Adds the given amount to the current stacks, or resets the duration timer if already at max stacks.
func add_stack(amount: int) -> void:
	if stacks == max_stacks:
		duration_timer = 0
	else:
		var old = stacks
		stacks = clamp(stacks + amount, 0, max_stacks)
		stacks_changed.emit(old, stacks)

## Removes the given amount from the current stacks and signals the abilities expiration if it reaches zero.
func remove_stacks(amount: int) -> void:
	var old = stacks
	stacks = clamp(stacks - amount, 0, max_stacks)
	if stacks == 0:
		expired.emit()
	else:
		stacks_changed.emit(old, stacks)