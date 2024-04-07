class_name EffectComponent
extends Node

## The effect component controls the effect lifecycle for an entity or other object.

signal passive_effect_added(effect: PassiveEffect)
signal passive_effect_removed(effect: PassiveEffect)
signal active_effect_added(effect: ActiveEffect)
signal active_effect_removed(effect: ActiveEffect)
signal damage_effect_added(effect: DamageEffect)
signal damage_effect_removed(effect: DamageEffect)
signal effect_removed(effect: PassiveEffect)
signal effects_cleared()

var passive_effects: Array[PassiveEffect] = []
var active_effects: Array[ActiveEffect] = []
var damage_effects: Array[DamageEffect] = []

func get_effect(uid: StringName) -> PassiveEffect:
	for child in get_children() as Array[PassiveEffect]:
		if child.uid == uid:
			return child
	return null

func clear_effects() -> void:
	for child in get_children() as Array[PassiveEffect]:
		effects_cleared.emit()
		child.queue_free()

# Passive effect controller --------------------------------------- #

## Adds a passive effect to be managed by the component.
func add_passive_effect(effect: PassiveEffect) -> void:
	var existing_effect = get_effect(effect.uid)
	if existing_effect:
		existing_effect.add_stack()
	else:
		passive_effect_added.emit(effect)
		passive_effects.append(effect)
		add_child(effect)

## Removes any passive effects matching the unique identifier.
func remove_passive_effect(uid: StringName) -> void:
	var passive_effects_copy = passive_effects.duplicate()
	for effect in passive_effects:
		if effect.uid == uid:
			passive_effect_removed.emit(effect)
			passive_effects_copy.erase(effect)
			effect.queue_free()
	passive_effects = passive_effects_copy

# ----------------------------------------------------------------- #

# Active effect controller ---------------------------------------- #

## Adds an active effect to be managed by the component.
func add_active_effect(effect: ActiveEffect) -> void:
	var existing_effect = get_effect(effect.uid)
	if existing_effect:
		existing_effect.add_stack()
	else:
		active_effect_added.emit(effect)
		effect.expired.connect(on_effect_expired.bind(effect), CONNECT_ONE_SHOT)
		active_effects.append(effect)
		add_child(effect)

## Removes any active effects matching the unique identifier.
func remove_active_effect(uid: StringName) -> void:
	var active_effects_copy = active_effects.duplicate()
	for effect in active_effects:
		if effect.uid == uid:
			active_effect_removed.emit(effect)
			active_effects_copy.erase(effect)
			effect.queue_free()
	active_effects = active_effects_copy

# ----------------------------------------------------------------- #

# Damage effect controller ---------------------------------------- #

## Adds an active effect to be managed by the component.
func add_damage_effect(effect: DamageEffect) -> void:
	damage_effect_added.emit(effect)
	damage_effects.append(effect)
	add_child(effect)

## Removes any damage effects matching the unique identifier.
func remove_damage_effect(uid: StringName) -> void:
	var damage_effects_copy = damage_effects.duplicate()
	for effect in damage_effects:
		if effect.uid == uid:
			damage_effect_removed.emit(effect)
			damage_effects_copy.erase(effect)
			effect.queue_free()
	damage_effects = damage_effects_copy

# ----------------------------------------------------------------- #

func on_effect_expired(effect: ActiveEffect) -> void:
	if effect in active_effects:
		active_effects.erase(effect)
	elif effect in damage_effects:
		damage_effects.erase(effect)
	effect.queue_free()