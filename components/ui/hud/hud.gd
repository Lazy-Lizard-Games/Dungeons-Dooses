extends Control
class_name Hud

## Health component.
@export var health: HealthComponent
## Stamina component.
@export var stamina: StaminaComponent
## Inventory component.
@export var inventory: InventoryComponent
## Action component.
@export var action: ActionComponent

## Health bar
@onready var health_bar: ResourceBar = $StatsContainer/VBoxContainer/HealthBar
## Stamina bar
@onready var stamina_bar: ResourceBar = $StatsContainer/VBoxContainer/StaminaBar

var resource_container_scene = preload ("res://components/ui/resource/resource.tscn")
var resource_containers: Array[ResourceContainer]

func _ready() -> void:
	health.updated.connect(on_health_updated)
	health.maximum_updated.connect(on_health_maximum_updated)
	stamina.stamina_updated.connect(on_stamina_updates)
	action.resource_added.connect(on_resource_added)

func on_health_updated(_previous: float, current: float) -> void:
	health_bar.progress_bar.value = current

func on_health_maximum_updated(previous: Attribute, current: Attribute) -> void:
	if previous:
		if previous.updated.is_connected(on_health_attribute_updated):
			previous.updated.disconnect(on_health_attribute_updated)
	if current:
		current.updated.connect(on_health_attribute_updated)
		on_health_attribute_updated(current.get_final_value())

func on_stamina_updates(_previous: float, current: float) -> void:
	stamina_bar.progress_bar.value = current

func on_stamina_maximum_updated(previous: Attribute, current: Attribute) -> void:
	if previous:
		if previous.updated.is_connected(on_stamina_attribute_updated):
			previous.updated.disconnect(on_stamina_attribute_updated)
		if current:
			current.updated.connect(on_stamina_attribute_updated)
			on_stamina_attribute_updated(current.get_final_value())

func on_health_attribute_updated(final_value: float) -> void:
	health_bar.progress_bar.max_value = final_value

func on_stamina_attribute_updated(final_value: float) -> void:
	stamina_bar.progress_bar.max_value = final_value

func on_resource_added(resource: StackingBientityResource) -> void:
	var resource_container = resource_container_scene.instantiate() as ResourceContainer
	resource_container.resource = resource
	resource_containers.append(resource_container)
	$ResourceContainer/GridContainer.add_child(resource_container)
