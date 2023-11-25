extends Node
class_name HealthComponent

## Triggered when health reaches 0.
signal died(damage: DamageData, source: HurtboxComponent)

## References the stats component of the entity for use by health values.
@export
var stats: StatsComponent
## Maximum health of the entity
@export
var max_health := 10.0:
	get:
		if stats:
			return stats.max_health
		return max_health
	set(h):
		max_health = h
		current_health = min(current_health, max_health)
## Current health of the entity
@onready
var current_health := max_health:
	set(h):
		current_health = clamp(h, 0, max_health)


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
	
	if stats:
		damage.amount * (1-stats.get_resistance(damage.type))
	current_health -= damage.amount
	if current_health == 0:
		died.emit(damage, source)
