extends MarginContainer
class_name SkillSlot

signal focus_changed(state: bool, skill: Skill)
signal slot_clicked(skill: Skill)

@export var skill: Skill
@onready var color_rect = $ColorRect


func _ready():
	color_rect.color = skill.color


func _on_focus_entered():
	focus_changed.emit(true, skill)


func _on_focus_exited():
	focus_changed.emit(false, skill)


func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			slot_clicked.emit(skill)
