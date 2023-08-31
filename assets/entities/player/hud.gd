extends CanvasLayer

@export var health_component: HealthComponent
@export var velocity_component: VelocityComponent
@export var weapon_component: WeaponComponent
@export var effect_component: EffectComponent

@onready var health_label: Label = $MarginContainer/VBoxContainer/HealthLabel
@onready var velocity_label: Label = $MarginContainer/VBoxContainer/VelocityLabel
@onready var speed_label: Label = $MarginContainer/VBoxContainer/SpeedLabel
@onready var skill_1: CenterContainer = $MarginContainer/SkillsContainer/Skill1
@onready var skill_2: CenterContainer = $MarginContainer/SkillsContainer/Skill2
@onready var skill_3: CenterContainer = $MarginContainer/SkillsContainer/Skill3
@onready var effects_container: GridContainer = $MarginContainer/EffectsContainer

var effect_container = preload("res://scenes/ui/hud/effect_container.tscn")

func _ready() -> void:
	effect_component.effect_added.connect(on_effect_added)
	weapon_component.skills_updated.connect(on_skills_updated)

func _process(_delta: float) -> void:
	check_labels()
	check_skills()

func check_labels() -> void:
	health_label.text = "Health: %s" % str(health_component.current_health)
	velocity_label.text = "Velocity: %s" % str(velocity_component.velocity)
	speed_label.text = "Speed: %s" % str(int(velocity_component.velocity.length()))

func check_skills() -> void:
	update_skill(0, skill_1)
	update_skill(1, skill_2)
	update_skill(2, skill_3)

func update_skill(index: int, skill: CenterContainer) -> void:
	if weapon_component.weapon_skills[index]:
		skill.modulate = Color.WHITE
		if weapon_component.weapon_skills[index].on_cooldown:
			skill.modulate = Color.BLACK

# Signal Connections --------------------------------------------------------- #

func on_effect_added(effect: Effect) -> void:
	var new_effect = effect_container.instantiate()
	new_effect.effect = effect
	effects_container.add_child(new_effect)

func on_skills_updated(skills: Array[WeaponSkill]) -> void:
	print(skills)
