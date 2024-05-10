class_name AbilityComponent
extends Node2D

## Triggered when an ability has added, removed, or swapped.
signal updated(index: int, ability: Ability)
## Triggered when an ability has been started.
signal ability_started(ability: Ability)

## The state component which will handle the processing of active abilities.
@export var state_component: StateComponent
## Controls whether abilities can be started.
@export var can_attack: bool

var abilities: Array[Ability]:
	get:
		return get_children() as Array[Ability]

## Starts the ability found at the index, if any.
func start_ability(index: int) -> void:
	var ability = get_ability(index)
	if ability and can_attack:
		state_component.change_state(ability)
		ability_started.emit(ability)

## Assigns the ability to the given index or the end if out of range.
func set_ability(index: int, ability: Ability) -> void:
	if get_child_count() < index:
		add_child(ability)
	get_children()[index] = ability
	updated.emit(index, ability)

## Returns the ability at the given index.
func get_ability(index: int) -> Ability:
	if get_child_count() <= index:
		return null
	var ability = get_children()[index]
	if !ability:
		return null
	return ability
