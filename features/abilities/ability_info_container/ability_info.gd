class_name AbilityInfoContainer
extends MarginContainer

@export var ability: AbilityData

@onready var name_label: Label = $Panel/MarginContainer/VBoxContainer/Name
@onready var description_label: Label = $Panel/MarginContainer/VBoxContainer/Description

func _ready():
	if ability:
		set_ability(ability)

func set_ability(new_ability: AbilityData) -> void:
	name_label.text = new_ability.name
	description_label.text = new_ability.description