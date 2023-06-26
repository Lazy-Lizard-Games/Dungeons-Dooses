extends PanelContainer

const Slot = preload("res://scenes/inventory/slot.tscn")

@onready var item_grid: GridContainer = $MarginContainer/ItemGrid

func set_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_updated.connect(update_item_grid)
	for slot in item_grid.get_children():
		slot.slot_clicked.connect(inventory_data.on_slot_clicked)
		slot.slot_focused.connect(inventory_data.on_slot_focused)
		slot.slot_unfocused.connect(inventory_data.on_slot_unfocused)
	update_item_grid(inventory_data)

func clear_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_updated.disconnect(update_item_grid)
	for slot in item_grid.get_children():
		slot.slot_clicked.disconnect(inventory_data.on_slot_clicked)
		slot.slot_focused.disconnect(inventory_data.on_slot_focused)
		slot.slot_unfocused.disconnect(inventory_data.on_slot_unfocused)

func update_item_grid(inventory_data: InventoryData) -> void:
	for i in inventory_data.slot_datas.size():
		var slot_data = inventory_data.slot_datas[i]
		var slot = item_grid.get_child(i)
		slot.clear_slot_data()
		if slot_data:
			slot.set_slot_data(slot_data)
