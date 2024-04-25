class_name AbilitySetContainer
extends MarginContainer

## Contains the data for a set of abilities and allows the player to:
##   - View the description of abilities
##   - Equip/unequip abilities for use in game

signal ability_clicked(ability: Ability, index: MouseButton)
signal ability_hovered(ability: Ability)

@export var data: AbilitySetData

@onready var offensive_row: HBoxContainer = $AspectRatioContainer/SetRows/OffensiveRow
@onready var defensive_row: HBoxContainer = $AspectRatioContainer/SetRows/DefensiveRow
@onready var supportive_row: HBoxContainer = $AspectRatioContainer/SetRows/SupportiveRow
@onready var dash_row: HBoxContainer = $AspectRatioContainer/SetRows/DashRow
@onready var special_row: HBoxContainer = $AspectRatioContainer/SetRows/SpecialRow

var ability_container_scene = preload ("res://features/abilities/ability_container/ability_container.tscn")

func _ready():
	if data:
		set_data(data)

func set_data(new_data: AbilitySetData) -> void:
	data = new_data
	# Do stuff with colour or whatever...

func set_abilities(abilities: Array) -> void:
	clear_children([offensive_row, defensive_row, supportive_row, dash_row, special_row])
	for ability in abilities:
		if ability is Ability:
			if ability.group != data.group:
				continue
			var ability_container: AbilityContainer = ability_container_scene.instantiate()
			ability_container.ability = ability
			ability_container.clicked.connect(on_ability_clicked.bind(ability))
			ability_container.hovered.connect(on_ability_hovered.bind(ability))
			match ability.type:
				Enums.AbilityType.Attack:
					offensive_row.add_child(ability_container)
				Enums.AbilityType.Defend:
					offensive_row.add_child(ability_container)
				Enums.AbilityType.Support:
					offensive_row.add_child(ability_container)
				Enums.AbilityType.Dash:
					offensive_row.add_child(ability_container)
				Enums.AbilityType.Special:
					offensive_row.add_child(ability_container)

func clear_children(nodes: Array[Control]) -> void:
	for node in nodes:
		if !node:
			continue
		for child in node.get_children():
			node.remove_child(child)

func on_ability_clicked(button_index: MouseButton, ability: Ability) -> void:
	ability_clicked.emit(ability, button_index)

func on_ability_hovered(ability: Ability) -> void:
	ability_hovered.emit(ability)