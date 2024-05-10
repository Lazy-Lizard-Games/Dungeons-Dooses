class_name AbilityContainer
extends MarginContainer

## Contains an ability that can be equipped by the player.

signal clicked(button_index: MouseButton)
signal hovered

@onready var icon: TextureRect = $AspectRatioContainer/MarginContainer/TextureRect

## The currently stored ability, if any.
var ability: Ability
var empty_icon: CompressedTexture2D = preload ("res://features/abilities/ability_container/empty_icon.jpg")

func set_ability(new_ability: Ability) -> void:
	ability = new_ability
	icon.texture = ability.icon if ability else empty_icon

func _on_texture_rect_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed:
			clicked.emit(event.button_index)

func _on_texture_rect_mouse_entered():
	hovered.emit()
