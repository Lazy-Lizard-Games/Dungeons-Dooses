extends Node
class_name StaminaComponent

enum StaminaState {
	Delaying,
	Recovering,
	Energized,
	Tireless,
}

signal exhausted(amount: float)
signal current_updated(previous: float, current: float)
signal maximum_updated(previous: float, current: float)
signal state_updated(previous: StaminaState, current: StaminaState)

## The stats component used to modify values, if any.
@export var stats_component: StatsComponent
## Maximum stamina.
@export var maximum: float:
	get:
		if stats_component:
			return maximum * stats_component.stamina_maximum.get_final_value()
		return maximum
	set(new):
		var old = maximum
		maximum = new
		maximum_updated.emit(old, new)
## ## Regeneration of stamina.
@export var regeneration: float:
	get:
		if stats_component:
			return regeneration * stats_component.stamina_regeneration.get_final_value()
		return regeneration
@export var delay_time: float:
	get:
		if stats_component:
			return delay_time * stats_component.stamina_delay.get_final_value()
		return delay_time
## Current stamina.
@onready var current: float:
	set(new):
		var old = current
		current = clampf(new, 0, maximum)
		current_updated.emit(old, new)
## Previous health.
@onready var previous := current
## Stamina run out and recovering.
var is_exhausted := false
var state: StaminaState = StaminaState.Energized:
	set(new):
		var old = state
		state = new
		state_updated.emit(old, state)
var delay_timer: float = 0

## Removes the amount from the current stamina.
func exhaust(amount: float) -> void:
	current -= amount
	delay_timer = -0.5
	state = StaminaState.Recovering

## Adds the amount to the current stamina.
func recover(amount: float) -> void:
	current += amount

func initialise_current() -> void:
	current = maximum

func _ready():
	call_deferred("initialise_current")

func _process(delta):
	match state:
		StaminaState.Recovering:
			delay_timer += delta
			current += regeneration * delta * (clamp(pow(delay_timer, 2) * 0.5, 0, delay_time) / delay_time)
			if current == maximum:
				state = StaminaState.Energized
