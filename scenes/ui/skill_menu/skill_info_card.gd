extends PanelContainer
class_name SkillInfoCard


@onready var skill_name: RichTextLabel = $MarginContainer/VBoxContainer/SkillName
@onready var description: RichTextLabel = $MarginContainer/VBoxContainer/Description
@onready var stacks: RichTextLabel = $MarginContainer/VBoxContainer/Stacks
# Current Effect
@onready var current_container: VBoxContainer = $MarginContainer/VBoxContainer/CurrentContainer
@onready var current_effect_label: RichTextLabel = $MarginContainer/VBoxContainer/CurrentContainer/EffectLabel
# Next Effect
@onready var next_container: VBoxContainer = $MarginContainer/VBoxContainer/NextContainer
@onready var next_effect_label: RichTextLabel = $MarginContainer/VBoxContainer/NextContainer/EffectLabel


var skill: Skill


func set_skill(new_skill: Skill) -> void:
	skill = new_skill
	update()


func clear_skill() -> void:
	skill = null
	skill_name.text = ""
	description.text = ""
	current_effect_label.hide()
	current_effect_label.text = ""
	next_effect_label.hide()
	next_effect_label.text = ""
	stacks.text = ""


func update() -> void:
	if not skill:
		return
	skill_name.text = "[center][b]%s[/b][/center]" % skill.name
	description.text = skill.description
	stacks.text = "[right]%s / %s[/right]" % [skill.stacks, skill.max_stacks]
	current_container.hide()
	if skill.stacks > 0:
		current_container.show()
		current_effect_label.text = "[color=springgreen]%s[/color]" % skill.get_effect_description(skill.stacks)
	next_container.hide()
	if skill.stacks < skill.max_stacks:
		next_container.show()
		next_effect_label.text = "[color=orange]%s[/color]" % skill.get_effect_description(skill.stacks+1)
