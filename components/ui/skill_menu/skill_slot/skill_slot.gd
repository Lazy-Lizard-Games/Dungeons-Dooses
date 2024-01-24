extends PanelContainer
class_name SkillSlot

signal clicked

## Skill held within skill slot.
@export var skill: Skill
## Texture rect to render skill icon.
@export var icon: TextureRect


func _ready():
	if !skill:
		var styleBox := StyleBoxFlat.new()
		styleBox.bg_color = Color(0, 0, 0, 0)
		add_theme_stylebox_override('panel', styleBox)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and skill:
			clicked.emit()
