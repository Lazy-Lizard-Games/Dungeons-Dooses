extends Node2D
class_name HealthComponent

signal health_changed(prev_health: float, cur_health: float, damage: DamageData)
signal died

@export var stats_component: StatsComponent
@export var max_health: float = 10.0 :
	get:
		if stats_component:
			return max_health * stats_component.health_mult
		return max_health
	set(value):
		max_health = value
		if current_health > max_health:
			current_health = max_health

var has_health_remaining: bool :
	get:
		return current_health > 0
var has_died : bool = false

var previous_health: float
var current_health: float:
	set(value):
		previous_health = current_health
		current_health = clampf(value, 0, max_health)


# Handle damage
func _ready() -> void:
	call_deferred("initialise_health")


func damage(damage_data: DamageData) -> void:
	current_health -= damage_data.damage
	health_changed.emit(previous_health, current_health, damage_data)
	if(not has_health_remaining and not has_died):
		died.emit()
		has_died = true
	if damage_data.damage != 0:
		var damage_float = FloatingTextManager.create_damage_float(global_position, damage_data)
		add_child(damage_float)


func initialise_health() -> void:
	current_health = max_health







