extends Node2D
class_name HealthComponent

## Triggered when health reaches 0.
signal died(damage: DamageData, source: HurtboxComponent)
signal damaged(damage: DamageData, source: HurtboxComponent)

@export var invulnerable := false

@export var max_health: Attribute
## Current health of the entity
@onready var current_health := max_health.get_final_value():
	set(h):
		current_health = clamp(h, 0, max_health.get_final_value())


## Checks whether the entity is dead or alive
var is_dead := false:
	get:
		return current_health == 0


## Main method for dealing damage to an entity
## TODO: Setup resistances with new attributes
func damage(damage_in: DamageData, source: HurtboxComponent) -> void:
	if is_dead:
		return
	
	if !invulnerable:
		current_health -= damage_in.amount
		damaged.emit(damage_in, source)
	TextHandler.create_damage_text(damage_in, global_position)
	if current_health == 0:
		died.emit(damage_in, source)
