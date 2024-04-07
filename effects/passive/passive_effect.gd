class_name PassiveEffect
extends Node

## Passive effects are applied through gear or skills and are removed manually. 

signal stacks_changed(prev: int, cur: int)
signal expired

## Icons provide a quick way to identify the effect.
@export var icon: ImageTexture
## The unique identifier quickly allows us to find any existing effects.
@export var uid: StringName

## Maximum stacks of the effect.
@export var max_stacks: int
var entity: Entity
var stacks: int

## Initialises the effect with the affected entity.
func init(entity_in: Entity) -> void:
	entity = entity_in
	stacks = 1

## Adds a stack to the effect.
func add_stack() -> void:
	var temp_prev = stacks
	stacks = min(stacks + 1, max_stacks)
	if stacks != temp_prev:
		stacks_changed.emit(temp_prev, stacks)

## Controls how actor stats should affect the applied effect.
func apply_actor_transforms(_actor: Entity) -> void:
	pass

## Applies the effect to the entity.
func enter() -> void:
	pass

## Removes the effect from the entity.
func exit() -> void:
	pass

func _ready() -> void:
	enter()
