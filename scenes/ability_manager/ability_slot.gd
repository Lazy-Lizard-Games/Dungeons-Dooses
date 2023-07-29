extends Control

signal slot_clicked(index: int)
signal slot_focused(index: int)
signal slot_unfocused(index: int)

@onready var ability_icon: TextureRect = $MarginContainer/AbilityIcon

var ability_data: AbilityData = null

func set_ability_data(ability: AbilityData) -> void:
	ability_data = ability
	ability_icon.texture = ability.texture

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT) \
			and event.is_pressed():
		slot_clicked.emit(get_index())

func _on_ability_icon_mouse_entered() -> void:
	slot_focused.emit(get_index())

func _on_ability_icon_mouse_exited() -> void:
	slot_unfocused.emit(get_index())
