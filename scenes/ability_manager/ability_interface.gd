extends Control

@onready var ability_manager: Control = $AbilityManager

func toggle_ability_manager(player: Character = null) -> void:
	visible = not visible
	if visible:
		ability_manager.set_manager_data(player)
