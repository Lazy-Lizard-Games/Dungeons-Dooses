extends Node
class_name AbilityComponent

signal updated(index: int, ability: Ability)

## Stores the available abilities for the entity to use.
@export var abilities: Array[Ability]


## Assigns the ability to the given index.
func set_ability(index: int, ability: Ability) -> void:
	if abilities.size() < index:
		abilities.resize(index)
	abilities.insert(index-1, ability)
	updated.emit(index, ability)


## fetches the ability at the given index.
func get_ability(index: int) -> Ability:
	if abilities.size() <= index:
		return null
	var ability = abilities[index]
	if !ability:
		return null
	return ability
