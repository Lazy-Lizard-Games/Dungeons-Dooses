extends Node
class_name HealthComponent

## Triggered when health reaches 0.
signal died(damage_data: DamageData, source: HurtboxComponent)
signal damaged(damage_data: DamageData, source: HurtboxComponent)
signal health_changed(previous_health: float, current_health: float)

## Immunity to all damage.
@export var invulnerable := false
## Maximum health.
@export var max_health: Attribute
## Current health.
@onready var current_health : float:
	set(h):
		previous_health = current_health
		current_health = clamp(h, 0, max_health.get_final_value())
		health_changed.emit(previous_health, current_health)
## Previous health.
@onready var previous_health := current_health

## Checks whether the entity is dead or alive
var is_dead := false:
	get:
		return current_health == 0


func _ready() -> void:
	current_health = max_health.get_final_value()


## Main method for dealing damage to an entity
## TODO: Setup resistances with new attributes
func damage(damage_data: DamageData, source: HurtboxComponent) -> void:
	if is_dead:
		return
	if !invulnerable:
		current_health -= damage_data.amount
	damaged.emit(damage_data, source)
	if current_health == 0:
		died.emit(damage_data, source)
