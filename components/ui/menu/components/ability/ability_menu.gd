class_name AbilityMenu
extends MarginContainer

@onready var abilities_container: AbilitiesContainer = $HBoxContainer/Abilities
@onready var details_container: AbilityInfoContainer = $HBoxContainer/Details

var player: Player

func init(player_in: Player) -> void:
	player = player_in
	abilities_container.clear_abilities()
	for ability in player.abilities.primary:
		abilities_container.add_ability(ability, Enums.AbilityType.Primary)
	for ability in player.abilities.secondary:
		abilities_container.add_ability(ability, Enums.AbilityType.Secondary)
	for ability in player.abilities.support:
		abilities_container.add_ability(ability, Enums.AbilityType.Support)
	for ability in player.abilities.passive:
		abilities_container.add_ability(ability, Enums.AbilityType.Passive)

func _on_abilities_ability_clicked(button: MouseButton, ability: AbilityData, type: Enums.AbilityType):
	match type:
		Enums.AbilityType.Primary:
			player.loadout.primary = ability if button == MOUSE_BUTTON_LEFT else null
		Enums.AbilityType.Secondary:
			player.loadout.secondary = ability if button == MOUSE_BUTTON_LEFT else null
		Enums.AbilityType.Support:
			player.loadout.support = ability if button == MOUSE_BUTTON_LEFT else null
		Enums.AbilityType.Passive:
			player.loadout.passive = ability if button == MOUSE_BUTTON_LEFT else null

func _on_abilities_ability_hovered(ability: AbilityData, type: Enums.AbilityType):
	details_container.set_ability(ability, type)
