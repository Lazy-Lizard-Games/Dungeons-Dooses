class_name AbilityMenu
extends MarginContainer

@onready var abilities_container: AbilitiesContainer = $HBoxContainer/Abilities
@onready var details_container: AbilityInfoContainer = $HBoxContainer/Details

var player: Player
var ability_component: AbilityComponent
var ability_set_container_scene = preload ("res://features/abilities/ability_set_container/ability_set_container.tscn")

func init(player_in: Player) -> void:
	player = player_in
	ability_component = player.ability_component
	load_abilities(ability_component.abilities)

func load_abilities(abilities: Array[Ability]) -> void:
	abilities_container.clear_abilities()
	for ability in abilities:
		abilities_container.add_ability(ability)

func _on_abilities_ability_clicked(button_index: MouseButton, ability: Ability):
	match button_index:
		MOUSE_BUTTON_LEFT:
			player.equip_ability(ability.type, ability.get_index())
		MOUSE_BUTTON_RIGHT:
			player.equip_ability(ability.type, -1)

func _on_abilities_ability_hovered(ability: Ability):
	details_container.set_ability(ability)
