class_name EffectComponent
extends Node

## The effect component controls the effect lifecycle for an entity or other object.

signal passive_effect_added(effect: PassiveEffect)
signal active_effect_added(effect: ActiveEffect)
signal damage_effect_added(effect: DamageEffect)
signal effect_removed(effect: PassiveEffect)
signal effects_cleared()

func get_effect(uid: StringName) -> PassiveEffect:
	for child in get_children() as Array[PassiveEffect]:
		if child.uid == uid:
			return child
	return null

func remove_effect(uid: StringName) -> void:
	for child in get_children() as Array[PassiveEffect]:
		if child.uid == uid:
			effect_removed.emit(child)
			child.queue_free()
		
func clear_effects() -> void:
	for child in get_children() as Array[PassiveEffect]:
		effects_cleared.emit()
		child.queue_free()

## Adds a passive effect to be managed by the component.
func add_passive_effect(effect: PassiveEffect) -> void:
	var existing_effect = get_effect(effect.uid)
	if existing_effect:
		existing_effect.add_stack()
	else:
		passive_effect_added.emit(effect)
		add_child(effect)

## Adds an active effect to be managed by the component.
func add_active_effect(effect: ActiveEffect) -> void:
	var existing_effect = get_effect(effect.uid)
	if existing_effect:
		existing_effect.add_stack()
	else:
		active_effect_added.emit(effect)
		effect.expired.connect(on_effect_expired.bind(effect), CONNECT_ONE_SHOT)
		add_child(effect)

## Adds an active effect to be managed by the component.
func add_damage_effect(effect: DamageEffect) -> void:
	damage_effect_added.emit(effect)
	add_child(effect)

func on_effect_expired(effect: ActiveEffect) -> void:
	effect.queue_free()