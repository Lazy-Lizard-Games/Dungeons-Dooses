extends Control

@onready var player_option: PanelContainer = $CenterContainer/ManagerBackground/ManagerContainer/EquippedContainer/OptionsContainer/PlayerOption
@onready var weapon_a_option: PanelContainer = $CenterContainer/ManagerBackground/ManagerContainer/EquippedContainer/OptionsContainer/WeaponAOption
@onready var weapon_b_option: PanelContainer = $CenterContainer/ManagerBackground/ManagerContainer/EquippedContainer/OptionsContainer/WeaponBOption

func set_manager_data(player: Character) -> void:
	player_option.set_title(player.title)
	if player.worn_weapons[0]:
		weapon_a_option.set_title(player.worn_weapons[0].title)
	if player.worn_weapons[1]:
		weapon_b_option.set_title(player.worn_weapons[1].title)
