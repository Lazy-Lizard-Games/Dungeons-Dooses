extends Node2D
class_name HealthComponent

enum HealthState {
	Regenerating,
	Healthy,
	Dead,
	Invincible,
}

class DamageOutcome:
	var final_damage_data: DamageData
	var final_health_state: HealthState

	func _init(damage_data: DamageData, health_state: HealthState):
		final_damage_data = damage_data
		final_health_state = health_state

signal damaged(damage_data: DamageData)
signal died(damage_data: DamageData)
signal current_updated(previous: float, current: float)
signal maximum_updated(previous: Attribute, current: Attribute)
signal state_updated(previous: HealthState, current: HealthState)

## The stats component used to modify values, if any.
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
@export var delay_time: float:
	get:
		if stats_component:
			return delay_time * stats_component.health_delay.get_final_value()
		return delay_time
## Current health.
@onready var current: float:
	set(new):
		var old = current
		current = clampf(new, 0, maximum)
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
var delay_timer: float = 0

## Deals damage to the current health and returns the outcome.
func damage(damage_data: DamageData) -> DamageOutcome:
	if state == HealthState.Invincible:
		damage_data.amount = 0
		return DamageOutcome.new(damage_data, state)
	if state == HealthState.Dead:
		damage_data.amount = 0
		return DamageOutcome.new(damage_data, state)
	current -= damage_data.amount
	if current == 0:
		state = HealthState.Dead
		died.emit(damage_data)
	else:
		delay_timer = -0.5
		state = HealthState.Regenerating
		damaged.emit(damage_data)
	return DamageOutcome.new(damage_data, state)

func apply_reistances(damage_data: DamageData) -> DamageData:
	if stats_component:
		var resistance = stats_component.get_final_affinity_for(damage_data.type)
		if resistance <= 0.5:
			return DamageData.new(damage_data.amount * 2, damage_data.type)
		return DamageData.new(damage_data.amount / resistance, damage_data.type)
	return damage_data

func damage_with_transforms(damage_data: DamageData) -> DamageOutcome:
	return damage(apply_reistances(damage_data))

## Restores amount to the current health.
func heal(amount: float) -> void:
	current += amount

func initialise_current() -> void:
	current = maximum

func _ready():
	call_deferred("initialise_current")

func _process(delta):
	match state:
		HealthState.Regenerating:
			delay_timer += delta
			current += regeneration * delta * (clamp(pow(delay_timer, 2) * 0.5, 0, delay_time) / delay_time)
			if current == maximum:
				state = HealthState.Healthy