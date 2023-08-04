extends Control

@onready var ability_name: Label = $PanelContainer/MarginContainer/VBoxContainer/AbilityName
@onready var ability_description: RichTextLabel = $PanelContainer/MarginContainer/VBoxContainer/AbilityDescription

func set_data(ability: AbilityData) -> void:
	ability_name.text = ability.get_ability_name()
	ability_description.text = ability.get_description()

func clear_data() -> void:
	ability_name.text = ""
	ability_description.text = ""
