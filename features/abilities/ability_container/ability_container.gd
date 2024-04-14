class_name AbilityContainer
extends MarginContainer

## Contains an ability that can be equipped by the player.
## Allows the player to:
## 	 - View ability information
## 	 - Equip abilities

signal clicked(button_index: MouseButton)
signal hovered

@export var ability_data: AbilityData

@onready var icon: TextureRect = $AspectRatioContainer/TextureRect

func _ready():
	if ability_data:
		set_ability_data(ability_data)

func set_ability_data(new_ability_data: AbilityData) -> void:
	icon.texture = new_ability_data.icon

func _on_texture_rect_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed:
			clicked.emit(event.button_index)

func _on_texture_rect_mouse_entered():
	hovered.emit()
