extends HBoxContainer
class_name SkillSlot

signal focus_changed(state: bool, skill: Skill)
signal slot_clicked(skill: Skill)

@export var skill: Skill
@onready var color_container = $ColorContainer
@onready var color_rect = $ColorContainer/ColorRect

var active = false


func _ready():
	resize()
	modulate = Color(0, 0, 0, 0)
	if skill:
		modulate = Color(0.5, 0.5, 0.5)
		color_rect.color = skill.color
		skill.state_changed.connect(on_skill_state_changed)


func resize() -> void:
	var a = min(size.y/size.x, 0.999)
	var ratio = (2*a)/(1-a) + 2
	color_container.size_flags_stretch_ratio = ratio


func _on_focus_entered():
	focus_changed.emit(true, skill)


func _on_focus_exited():
	focus_changed.emit(false, skill)


func _on_gui_input(event):
	if event is InputEventMouseButton and active:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			slot_clicked.emit(skill)


func on_skill_state_changed(state: bool) -> void:
	active = state
	modulate = Color(0.5, 0.5, 0.5)
	if active:
		modulate = Color(1, 1, 1)
