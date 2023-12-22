extends Control
class_name Hud

## Health component.
@export var health: HealthComponent
## Inventory component.
@export var inventory: InventoryComponent
## Health bar
@onready var health_bar := $StatsContainer/VBoxContainer/HealthBar

func _ready() -> void:
	health.health_changed.connect(on_health_changed)
	health.max_health.updated.connect(on_max_health_updated)
	health_bar.value = health.current_health
	health_bar.max_value = health.max_health.get_final_value()


func on_health_changed(previous_health: float, current_health: float) -> void:
	health_bar.value = current_health


func on_max_health_updated() -> void:
	health_bar.max_value = health.max_health.get_final_value()
