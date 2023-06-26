extends StaticBody2D

signal toggle_inventory(external_inventory_owner)

@export var inventory_data: InventoryData
var _name = "Chest"

func player_interact() -> void:
	toggle_inventory.emit(self)
