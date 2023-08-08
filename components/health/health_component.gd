extends Node2D
class_name HealthComponent

signal health_changed(health_update)
signal died

@export var stats: StatsComponent
@export var max_health: float = 10.0 :
	get:
		return max_health
	set(value):
		max_health = value * stats.health_mult if stats else value
		if current_health > max_health:
			current_health = max_health
#@export var stats: StatsComponent

var has_health_remaining: bool :
	get:
		return current_health > 0
var has_died : bool = false

var current_health: float :
	get:
		return current_health
	set(value):
		current_health = clampf(value, 0, max_health)
		#emit an informed update about the health change (old health, new health, max health, is_heal, etc)
		if(!has_health_remaining && !has_died):
			died.emit()
			has_died = true

# Handle damage, heal

func _ready() -> void:
	call_deferred("initialise_health")

func damage(damage: float) -> void:
	current_health -= damage
	var damage_float = FloatingTextManager.create_damage_float(global_position, damage)
	add_child(damage_float)

func heal(value: float) -> void:
	damage(-value)

func set_max_health(value: float) -> void:
	max_health = value

func initialise_health() -> void:
	current_health = max_health







