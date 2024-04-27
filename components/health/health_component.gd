extends Node
class_name HealthComponent

enum HealthState {
	Idle,
	Regenerating,
	Healthy,
	Dead,
	Invincible,
}

signal damaged(amount: float, type: Enums.DamageType)
signal died(amount: float, type: Enums.DamageType)
signal current_updated(previous: float, current: float)
signal maximum_updated(previous: Attribute, current: Attribute)
signal state_updated(previous: HealthState, current: HealthState)

@export var stats_component: StatsComponent
## Immunity to all damage.
@export var invulnerable := false
## Maximum health if attributes not attached or no health attribute found.
@export var maximum: float:
	get:
		if stats_component:
			return maximum * stats_component.health_maximum.get_final_value()
		return maximum
	set(new):
		var old = maximum
		maximum = new
		maximum_updated.emit(old, new)
## Health regen if attributes not attached or no health regen attribute found.
@export var regeneration: float:
	get:
		if stats_component:
			return regeneration * stats_component.health_regeneration.get_final_value()
		return regeneration
## Current health.
@onready var current: float:
	set(new):
		var old = current
		current = new
		current_updated.emit(old, new)
## Previous health.
@onready var previous := current

## Checks whether the entity is dead or alive
var is_dead := false:
	get:
		return current == 0
var state: HealthState = HealthState.Healthy:
	set(new):
		var old = state
		state = new
		state_updated.emit(old, state)

func _process(delta):
	if state == HealthState.Regenerating:
		current += regeneration * delta
		if current == maximum:
			state = HealthState.Healthy

## Deals damage to the current health and returns the healths state.
func damage(amount: float, type: Enums.DamageType) -> HealthState:
	if invulnerable:
		return HealthState.Invincible
	if is_dead:
		return HealthState.Dead
	
	current = clampf(current - amount, 0, maximum)
	if current == 0:
		state = HealthState.Dead
		died.emit(amount, type)
		return HealthState.Dead
	else:
		state = HealthState.Idle
		damaged.emit(amount, type)
		return HealthState.Idle

## Restores amount to the current health.
func heal(amount: float) -> void:
	current += amount
