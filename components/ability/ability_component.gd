class_name AbilityComponent
extends Node2D

## Triggered when an ability has added, removed, or swapped.
signal updated(index: int, ability: Ability)
## Triggered when an ability has been started.
signal ability_started(ability: Ability)

## The abilities handled by this ability component.
@export var abilities: Array[Ability]
## The mob that will be used to cast abilities.
@export var mob: Mob
## Controls whether abilities can be started.
@export var can_attack: bool
## Data that an ability can use to change how they work.
# @export_group("Extra mods")
# @export var damage_mods: Array[DamageData]
# @export var effect_mods: Array[EffectData]
# ^ Disabling for now until there is time and a better idea

## Starts the ability found at the index, if any.
func start_ability(index: int) -> void:
	if can_attack:
		var ability = get_ability(index)
		if ability and ability.start():
			ability_started.emit(ability)

## Assigns the ability to the given index or the end if out of range.
func set_ability(index: int, ability: Ability) -> void:
	if abilities.size() <= index:
		abilities.resize(index + 1)
	abilities[index] = ability
	ability.init(self)
	updated.emit(index, ability)

## Returns the ability at the given index.
func get_ability(index: int) -> Ability:
	if index >= abilities.size() or index < 0:
		return null
	return abilities[index]

func process_ability_timers(delta: float) -> void:
	for ability in abilities:
		ability.process_timers(delta)