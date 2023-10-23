extends MarginContainer
class_name HUD

@export var health_component: HealthComponent
@export var velocity_component: VelocityComponent
@export var weapon_component: WeaponComponent
@export var effect_component: EffectComponent

@onready var health_label: Label = $VBoxContainer/HealthLabel
@onready var velocity_label: Label = $VBoxContainer/VelocityLabel
@onready var speed_label: Label = $VBoxContainer/SpeedLabel

@onready var skills_container = $SkillsContainer
@onready var effects_container = $EffectsContainer

var effect_container = preload("res://scenes/ui/hud/effect_container.tscn")

# Overrides ------------------------------------------------------------------ #
func _ready() -> void:
	effect_component.effect_added.connect(on_effect_added)
	weapon_component.skills_updated.connect(on_skills_updated)
	health_component.health_changed.connect(on_health_changed)


func _process(_delta: float) -> void:
	check_labels()
	check_skills()


# General -------------------------------------------------------------------- #
func check_labels() -> void:
	health_label.text = "Health: %s" % str(health_component.current_health)
	velocity_label.text = "Velocity: %s" % str(velocity_component.velocity)
	speed_label.text = "Speed: %s" % str(int(velocity_component.velocity.length()))


func check_skills() -> void:
	pass


# Signal Connections --------------------------------------------------------- #
func on_effect_added(effect: Effect) -> void:
	var new_effect = effect_container.instantiate()
	new_effect.effect = effect
	effects_container.add_child(new_effect)


func on_skills_updated(skills: Array[WeaponSkill]) -> void:
	pass


func on_health_changed(prev_health: float, cur_health: float, damage: DamageData) -> void:
	pass
