extends CanvasLayer

@export var health_component: HealthComponent
@export var velocity_component: VelocityComponent
@export var weapon_component: WeaponComponent

@onready var health_label: Label = $MarginContainer/VBoxContainer/HealthLabel
@onready var velocity_label: Label = $MarginContainer/VBoxContainer/VelocityLabel
@onready var speed_label: Label = $MarginContainer/VBoxContainer/SpeedLabel
@onready var skill_1: CenterContainer = $MarginContainer/SkillsContainer/Skill1
@onready var skill_2: CenterContainer = $MarginContainer/SkillsContainer/Skill2
@onready var skill_3: CenterContainer = $MarginContainer/SkillsContainer/Skill3


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
