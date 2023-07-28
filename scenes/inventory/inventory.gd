extends PanelContainer

const Slot = preload("res://scenes/inventory/slot.tscn")

@onready var item_grid: GridContainer = $MarginContainer/ItemGrid
@onready var inv_bg: TileMap = $MarginContainer/InventoryBackground

func set_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_updated.connect(populate_item_grid)
	populate_item_grid(inventory_data)

func clear_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_updated.disconnect(populate_item_grid)

func populate_item_grid(inventory_data: InventoryData) -> void:
	for child in item_grid.get_children():
		child.queue_free()
	
	for slot_data in inventory_data.slot_datas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		
		slot.slot_clicked.connect(inventory_data.on_slot_clicked)
		slot.slot_focused.connect(inventory_data.on_slot_focused)
		slot.slot_unfocused.connect(inventory_data.on_slot_unfocused)
		
		if slot_data:
			slot.set_slot_data(slot_data)
	
	var inv_size = inventory_data.slot_datas.size()
	var cols = item_grid.columns
	inv_bg.clear()
	var cells: Array[Vector2i]
	for x in range(cols):
		for y in range(ceil(inv_size/cols)):
			cells.append(Vector2i(x, y))
	inv_bg.set_cells_terrain_connect(0, cells, 0, 0)
