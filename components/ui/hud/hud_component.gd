extends Control
class_name Hud

## Health component.
@export var health: HealthComponent
## Inventory component.
@export var inventory: InventoryComponent
## Health bar
@export var health_bar: ProgressBar

func _ready() -> void:
	health.updated.connect(on_health_updated)
	health.max_updated.connect(on_max_updated)


func on_health_updated(previous: float, current: float) -> void:
	health_bar.value = current


func on_max_updated(previous: Attribute, current: Attribute) -> void:
	if previous:
		if previous.updated.is_connected(on_attribute_updated):
			previous.updated.disconnect(on_attribute_updated)
	if current:
		current.updated.connect(on_attribute_updated)
		on_attribute_updated(current.get_final_value())


func on_attribute_updated(final_value: float) -> void:
	health_bar.max_value = final_value
