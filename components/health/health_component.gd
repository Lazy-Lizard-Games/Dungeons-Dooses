extends Node
class_name HealthComponent

## Called when health reaches 0
signal died(damage: DamageData, source: HurtboxComponent)

## Maximum health of the entity
@export
var max_health := 10.0:
	set(h):
		max_health = h
		current_health = min(current_health, max_health)

## Current health of the entity
@onready
var current_health := max_health:
	set(h):
		print(h)
		current_health = clamp(h, 0, max_health)

@export_category("Resistances")
@export var normal_resistance := 0.0
@export var fire_resistance := 0.0
@export var frost_resistance := 0.0
@export var shock_resistance := 0.0
@export var poison_resistance := 0.0

var resistances = {
	Globals.DAMAGE.NORMAL: normal_resistance,
	Globals.DAMAGE.FIRE: fire_resistance,
	Globals.DAMAGE.FROST: frost_resistance,
	Globals.DAMAGE.SHOCK: shock_resistance,
	Globals.DAMAGE.POISON: poison_resistance,
}

## Checks whether the entity is dead or alive
var is_dead := false:
	get:
		return current_health == 0

## Checks if the entity can take damage or not
var invulnerable := false


## Main method for dealing damage to an entity
func damage(damage: DamageData, source: HurtboxComponent) -> void:
	if is_dead:
		return
	
	if invulnerable:
		return
	
	current_health -= damage.amount * (1-resistances[damage.type])
	if current_health == 0:
		died.emit(damage, source)
