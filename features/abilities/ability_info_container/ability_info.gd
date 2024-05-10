class_name AbilityInfoContainer
extends MarginContainer

var ability: Ability

@onready var name_label: Label = $Panel/MarginContainer/VBoxContainer/Name
@onready var description_label: Label = $Panel/MarginContainer/VBoxContainer/Description

func set_ability(new_ability: Ability) -> void:
	if new_ability:
		name_label.text = new_ability.name
		description_label.text = new_ability.description
	else:
		name_label.text = "No ability equipped... yet"
		description_label.text = "Select an ability of the correct type and place it in this slot to equip it. Once equipped, it will be usable when in combat or exploring."