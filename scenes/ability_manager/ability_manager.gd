extends Control

@onready var player_option: PanelContainer = $CenterContainer/ManagerBackground/ManagerContainer/EquippedContainer/OptionsContainer/PlayerOption
@onready var weapon_a_option: PanelContainer = $CenterContainer/ManagerBackground/ManagerContainer/EquippedContainer/OptionsContainer/WeaponAOption
@onready var weapon_b_option: PanelContainer = $CenterContainer/ManagerBackground/ManagerContainer/EquippedContainer/OptionsContainer/WeaponBOption
@onready var ability_primary: AspectRatioContainer = $CenterContainer/ManagerBackground/ManagerContainer/EquippedContainer/EquippedAbilities/AbilityPrimary
@onready var ability_secondary: AspectRatioContainer = $CenterContainer/ManagerBackground/ManagerContainer/EquippedContainer/EquippedAbilities/AbilitySecondary
@onready var ability_tertiary: AspectRatioContainer = $CenterContainer/ManagerBackground/ManagerContainer/EquippedContainer/EquippedAbilities/AbilityTertiary
@onready var ability_list: GridContainer = $CenterContainer/ManagerBackground/ManagerContainer/AbilityList

@onready var ability_slot = preload("res://scenes/ability_manager/ability_slot.tscn")

var selected_index = 0

func set_manager_data(player: Character) -> void:
	clear_data()
	player_option.set_option(player)
	weapon_a_option.set_option(player.worn_weapons[0])
	weapon_b_option.set_option(player.worn_weapons[1])
	update_equipped_abilities()

func clear_data() -> void:
	weapon_a_option.visible = false
	weapon_b_option.visible = false

func get_equipped_abilities() -> Array[AbilityData]:
	match selected_index:
		0:
			return player_option.get_abilities()
		1:
			return weapon_a_option.get_abilities()
		2:
			return weapon_b_option.get_abilities()
		_:
			return [null, null, null]

func get_ability_list() -> Array[AbilityData]:
	return []

func set_equipped_abilities(abilities: Array[AbilityData]) -> void:
	ability_primary.set_ability_data(abilities[0])
	ability_secondary.set_ability_data(abilities[1])
	ability_tertiary.set_ability_data(abilities[2])

func update_equipped_abilities() -> void:
	set_equipped_abilities(get_equipped_abilities())
	var ability_options = get_ability_list()
	
	for child in ability_list.get_children():
		ability_list.remove(child)
	
	for ability in ability_options:
		var slot = ability_slot.instantiate()
		ability_list.add_child(slot)
		slot.set_ability_data(ability)
		slot.slot_clicked.connect(on_slot_clicked)
		slot.slot_focused.connect(on_slot_focused)
		slot.slot_unfocused.connect(on_slot_unfocused)

func on_slot_clicked(index: int) -> void:
	print(index)

func on_slot_focused(index: int) -> void:
	print(index)

func on_slot_unfocused(index: int) -> void:
	print(index)

func _on_option_clicked(index: int) -> void:
	if index != selected_index:
		selected_index = index
	update_equipped_abilities()
