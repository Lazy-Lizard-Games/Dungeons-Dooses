extends Control
class_name Hud

## Health component.
@export var health: HealthComponent
## Stamina component.
@export var stamina: StaminaComponent
## Inventory component.
@export var inventory: InventoryComponent
## Action component.
@export var effect_component: EffectComponent

## Health bar
@onready var health_bar: ResourceBar = $StatsContainer/VBoxContainer/HealthBar
## Stamina bar
@onready var stamina_bar: ResourceBar = $StatsContainer/VBoxContainer/StaminaBar
@onready var effect_container: GridContainer = $EffectContainer/GridContainer
var resource_container_scene = preload ("res://components/ui/resource/resource.tscn")

func _ready() -> void:
	health.updated.connect(on_health_updated)
	health.maximum_updated.connect(on_health_maximum_updated)
	stamina.stamina_updated.connect(on_stamina_updates)
	effect_component.effect_added.connect(on_effect_added)
	effect_component.effect_removed.connect(on_effect_removed)

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

func on_effect_added(effect: PassiveEffect) -> void:
	var resource_container = resource_container_scene.instantiate() as ResourceContainer
	resource_container.effect = effect
	effect_container.add_child(resource_container)

func on_effect_removed(effect: PassiveEffect) -> void:
	for child in effect_container.get_children() as Array[ResourceContainer]:
		if child.effect.uid == effect.uid:
			effect_container.remove_child(child)
			child.queue_free()