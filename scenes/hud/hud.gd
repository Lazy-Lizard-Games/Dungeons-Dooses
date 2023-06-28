extends Control

@onready var equipment: Control = $Equipment

func set_player_equipment_data(equipment_data: InventoryData):
	equipment_data.inventory_updated.connect(equipment.on_equipment_updated)

func on_weapon_swap(index: int):
	equipment.swap_weapon(index)
