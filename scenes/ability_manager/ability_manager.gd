extends Control

@onready var player_option: PanelContainer = $CenterContainer/ManagerBackground/ManagerContainer/EquippedContainer/OptionsContainer/PlayerOption
@onready var weapon_a_option: PanelContainer = $CenterContainer/ManagerBackground/ManagerContainer/EquippedContainer/OptionsContainer/WeaponAOption
@onready var weapon_b_option: PanelContainer = $CenterContainer/ManagerBackground/ManagerContainer/EquippedContainer/OptionsContainer/WeaponBOption
@onready var ability_primary: AspectRatioContainer = $CenterContainer/ManagerBackground/ManagerContainer/EquippedContainer/EquippedAbilities/AbilityPrimary
@onready var ability_secondary: AspectRatioContainer = $CenterContainer/ManagerBackground/ManagerContainer/EquippedContainer/EquippedAbilities/AbilitySecondary
@onready var ability_tertiary: AspectRatioContainer = $CenterContainer/ManagerBackground/ManagerContainer/EquippedContainer/EquippedAbilities/AbilityTertiary
@onready var ability_list: GridContainer = $CenterContainer/ManagerBackground/ManagerContainer/AbilityList
@onready var grabbed_slot: AspectRatioContainer = $GrabbedSlot

@onready var ability_slot = preload("res://scenes/ability_manager/ability_slot.tscn")

@onready var options = [player_option, weapon_a_option, weapon_b_option]
var selected_index = 0
var grabbed_ability = null

func _physics_process(delta: float) -> void:
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position()

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
	return options[selected_index].get_abilities()

func get_ability_list() -> Array:
	return Globals.get_abilities(options[selected_index].get_type())

func set_equipped_abilities(abilities: Array[AbilityData]) -> void:
	ability_primary.set_ability_data(abilities[0])
	ability_secondary.set_ability_data(abilities[1])
	ability_tertiary.set_ability_data(abilities[2])

func update_equipped_abilities() -> void:
	grabbed_ability = null
	update_grabbed_slot()
	set_equipped_abilities(get_equipped_abilities())
	var ability_options = get_ability_list()
	
	for child in ability_list.get_children():
		ability_list.remove_child(child)
	
	for ability in ability_options:
		var slot = ability_slot.instantiate()
		ability_list.add_child(slot)
		slot.set_ability_data(ability)
		slot.slot_clicked.connect(on_slot_clicked)
		slot.slot_focused.connect(on_slot_focused)
		slot.slot_unfocused.connect(on_slot_unfocused)

func on_slot_clicked(index: int) -> void:
	print("Slot #%s clicked!" % index)
	grabbed_ability = ability_list.get_child(index).get_ability()
	update_grabbed_slot()

func on_slot_focused(index: int) -> void:
	print(ability_list.get_child(index).get_ability().name)

func on_slot_unfocused(index: int) -> void:
	pass

func update_grabbed_slot() -> void:
	grabbed_slot.hide()
	if grabbed_ability:
		grabbed_slot.set_ability_data(grabbed_ability)
		grabbed_slot.show()

func _on_option_clicked(index: int) -> void:
	if index != selected_index:
		selected_index = index
	update_equipped_abilities()

func _on_ability_slot_clicked(index) -> void:
	if options[selected_index].can_edit(index):
		print("Can edit!")
