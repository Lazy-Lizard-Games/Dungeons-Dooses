class_name AbilitySetContainer
extends MarginContainer

## Contains the data for a set of abilities and allows the player to:
##   - View the description of abilities
##   - Equip/unequip abilities for use in game

signal ability_clicked(ability: Ability, index: MouseButton)
signal ability_hovered(ability: Ability)

@export var data: AbilitySetData

@onready var primary_abilities: HBoxContainer = $AspectRatioContainer/SetRows/OffensiveRow
@onready var secondary_abilities: HBoxContainer = $AspectRatioContainer/SetRows/DefensiveRow
@onready var support_abilities: HBoxContainer = $AspectRatioContainer/SetRows/SupportiveRow
@onready var passive_abilities: HBoxContainer = $AspectRatioContainer/SetRows/DashRow

var ability_container_scene = preload ("res://features/abilities/ability_container/ability_container.tscn")

func _ready():
	if data:
		set_data(data)

func set_data(new_data: AbilitySetData) -> void:
	data = new_data
	# Do stuff with colour or whatever...

func set_abilities(abilities: Array) -> void:
	clear_children([primary_abilities, secondary_abilities, support_abilities, passive_abilities])
	for ability in abilities:
		if ability is Ability:
			if ability.group != data.group:
				continue
			var ability_container: AbilityContainer = ability_container_scene.instantiate()
			ability_container.ability = ability
			ability_container.clicked.connect(on_ability_clicked.bind(ability))
			ability_container.hovered.connect(on_ability_hovered.bind(ability))
			match ability.type:
				Enums.AbilityType.Primary:
					primary_abilities.add_child(ability_container)
				Enums.AbilityType.Secondary:
					secondary_abilities.add_child(ability_container)
				Enums.AbilityType.Support:
					support_abilities.add_child(ability_container)
				Enums.AbilityType.Passive:
					passive_abilities.add_child(ability_container)

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
