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
	health.current_updated.connect(on_health_current_updated)
	health.maximum_updated.connect(on_health_maximum_updated)
	stamina.current_updated.connect(on_stamina_current_updated)
	stamina.maximum_updated.connect(on_stamina_maximum_updated)
	effect_component.effect_added.connect(on_effect_added)
	effect_component.effect_removed.connect(on_effect_removed)

func on_health_current_updated(_previous: float, current: float) -> void:
	health_bar.progress_bar.value = current

func on_health_maximum_updated(_previous: float, current: float) -> void:
	health_bar.progress_bar.max_value = current

func on_stamina_current_updated(_previous: float, current: float) -> void:
	stamina_bar.progress_bar.value = current

func on_stamina_maximum_updated(_previous: float, current: float) -> void:
	stamina_bar.progress_bar.value = current

func on_effect_added(effect: Effect) -> void:
	var resource_container = resource_container_scene.instantiate() as ResourceContainer
	resource_container.effect = effect
	effect_container.add_child(resource_container)

func on_effect_removed(effect: Effect) -> void:
	for child in effect_container.get_children() as Array[ResourceContainer]:
		if child.effect.name == effect.name:
			effect_container.remove_child(child)
			child.queue_free()