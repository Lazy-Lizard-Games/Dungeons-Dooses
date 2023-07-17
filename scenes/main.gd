extends Node2D

const PickUp = preload("res://interactable/pickup.tscn")

@onready var player: Character = $Player
@onready var inventory_interface: Control = $UI/InventoryInterface
@onready var hud: Control = $UI/HUD
@onready var pickups: Node2D = $Pickups

func _ready() -> void:
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player.inventory_data)
	inventory_interface.set_player_equipment_data(player.equipment_data)
	player.swap_weapon.connect(hud.on_weapon_swap)
	hud.set_player_equipment_data(player.equipment_data)
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggle_inventory_interface)

func toggle_inventory_interface(external_inventory_owner = null) -> void:
	inventory_interface.toggle_inventory(external_inventory_owner)

func _on_inventory_interface_drop_slot_data(slot_data) -> void:
	var pickup = PickUp.instantiate()
	pickup.slot_data = slot_data
	pickup.position = player.position
	pickups.add_child(pickup)
