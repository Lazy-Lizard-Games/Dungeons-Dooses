class_name AbilityContainer
extends MarginContainer

## Contains an ability that can be equipped by the player.
## Allows the player to:
## 	 - View ability information
## 	 - Equip abilities

signal clicked(button_index: MouseButton)
signal hovered

## The currently stored ability, if any.
@export var ability: Ability
## The type of abilities allowed to be stored.
@export var type: Enums.AbilityType

@onready var icon: TextureRect = $AspectRatioContainer/MarginContainer/TextureRect

var empty_icon: CompressedTexture2D = preload ("res://features/abilities/ability_container/empty_icon.jpg")

func _ready():
	set_ability(ability)

func set_ability(new_ability: Ability) -> void:
	ability = new_ability
	icon.texture = ability.icon if ability else empty_icon

func _on_texture_rect_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed:
			clicked.emit(event.button_index)

func _on_texture_rect_mouse_entered():
	hovered.emit()
