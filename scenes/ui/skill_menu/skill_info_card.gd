extends PanelContainer
class_name SkillInfoCard


@onready var skill_name: Label = $VBoxContainer/Name
@onready var description: Label = $VBoxContainer/Description
@onready var stacks: Label = $VBoxContainer/Stacks

var skill: Skill


func set_skill(new_skill: Skill) -> void:
	skill = new_skill
	skill_name.text = skill.name
	description.text = skill.description
	stacks.text = "%s / %s" % [skill.stacks, skill.max_stacks]


func clear_skill() -> void:
	skill = null
	skill_name.text = ""
	description.text = ""
	stacks.text = ""


func update() -> void:
	if skill:
		stacks.text = "%s / %s" % [skill.stacks, skill.max_stacks]
