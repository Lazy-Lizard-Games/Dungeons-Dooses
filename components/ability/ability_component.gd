class_name AbilityComponent
extends Node2D

signal updated(index: int, ability: Ability)

func init(entity: Entity) -> void:
	for child in get_children():
		child.entity = entity

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
