extends PanelContainer
class_name SkillInfoCard


@onready var skill_name: Label = $VBoxContainer/Name
@onready var description: Label = $VBoxContainer/Description
@onready var stacks: Label = $VBoxContainer/Stacks
@onready var current_effect = $VBoxContainer/CurrentEffect
@onready var next_effect = $VBoxContainer/NextEffect

var skill: Skill


func set_skill(new_skill: Skill) -> void:
	skill = new_skill
	update()


func clear_skill() -> void:
	skill = null
	skill_name.text = ""
	description.text = ""
	current_effect.text = ""
	next_effect.text = ""
	stacks.text = ""


func update() -> void:
	if not skill:
		return
	skill_name.text = skill.name
	description.text = skill.description
	current_effect.text = skill.get_detail(skill.stacks-1)
	next_effect.text = skill.get_detail(skill.stacks)
	stacks.text = "%s / %s" % [skill.stacks, skill.max_stacks]
