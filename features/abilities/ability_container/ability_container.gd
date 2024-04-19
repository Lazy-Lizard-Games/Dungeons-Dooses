class_name AbilityContainer
extends MarginContainer

## Contains an ability that can be equipped by the player.
## Allows the player to:
## 	 - View ability information
## 	 - Equip abilities

signal clicked(button_index: MouseButton)
signal hovered

@export var ability: Ability

@onready var icon: TextureRect = $AspectRatioContainer/MarginContainer/TextureRect

func _ready():
	if ability:
		set_ability(ability)

func set_ability(new_ability: Ability) -> void:
	icon.texture = new_ability.icon

func _on_texture_rect_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed:
			clicked.emit(event.button_index)

func _on_texture_rect_mouse_entered():
	hovered.emit()
