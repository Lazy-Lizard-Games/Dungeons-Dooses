extends Control
class_name HudComponent

## Health component.
@export var health: HealthComponent
## Inventory component.
@export var inventory: InventoryComponent
## Action component.
@export var action: ActionComponent
## Health bar
@export var health_bar: ProgressBar

var resource_container_scene = preload("res://components/ui/resource/resource.tscn")
var resource_containers: Array[ResourceContainer]

func _ready() -> void:
	health.updated.connect(on_health_updated)
	health.maximum_updated.connect(on_maximum_updated)
	action.resource_added.connect(on_resource_added)


func on_health_updated(_previous: float, current: float) -> void:
	health_bar.value = current


func on_maximum_updated(previous: Attribute, current: Attribute) -> void:
	if previous:
		if previous.updated.is_connected(on_attribute_updated):
			previous.updated.disconnect(on_attribute_updated)
	if current:
		current.updated.connect(on_attribute_updated)
		on_attribute_updated(current.get_final_value())


func on_attribute_updated(final_value: float) -> void:
	health_bar.max_value = final_value


func on_resource_added(resource: StackingResource) -> void:
	var resource_container = resource_container_scene.instantiate() as ResourceContainer
	resource_container.resource = resource
	resource_containers.append(resource_container)
	$ResourceContainer/GridContainer.add_child(resource_container)
