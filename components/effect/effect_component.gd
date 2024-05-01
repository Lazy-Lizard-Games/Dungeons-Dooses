class_name EffectComponent
extends Node

## The effect component controls the effect lifecycle for an entity or other object.

signal effect_added(effect: Effect)
signal effect_removed(effect: Effect)
signal effects_cleared()

var effects: Array[Effect] = []

func get_effect(search: StringName) -> Effect:
	for effect in effects:
		if effect.name == search:
			return effect
	return null

func clear_effects() -> void:
	for effect in effects:
		effect.exit()
	effects.clear()
	effects_cleared.emit()

## Adds an effect.
func add_effect(effect: Effect) -> void:
	var existing_effect = get_effect(effect.name)
	if existing_effect:
		existing_effect.add_stack(1)
	else:
		effect.init(self)
		effects.append(effect)
		effect.expired.connect(_on_effect_expired.bind(effect), CONNECT_ONE_SHOT)
		effect_added.emit(effect)

## Removes an effect that matches the search string.
func remove_effect(effect) -> void:
	effect.exit()
	effects.erase(effect)
	effect_removed.emit(effect)

## Called whenever an effect expires.
func _on_effect_expired(effect: Effect) -> void:
	remove_effect(effect)