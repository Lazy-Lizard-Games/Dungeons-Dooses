extends Control

signal drop_slot_data(slot_data: SlotData)

var grabbed_slot_data: SlotData
var external_inventory_owner

@onready var player: Control = $Inventories/Player
@onready var player_inventory: PanelContainer = $Inventories/Player/PlayerInventory
@onready var player_equipment: PanelContainer = $Inventories/Player/PlayerEquipment
@onready var grabbed_slot: PanelContainer = $GrabbedSlot
@onready var external_inventory: PanelContainer = $Inventories/ExternalInventory
@onready var info_card: Control = $InfoCard

func _physics_process(delta: float) -> void:
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(5, 5)
	
	if info_card.visible:
		info_card.global_position = get_global_mouse_position() + Vector2(5, 5)

func toggle_inventory(external_owner = null) -> void:
	if visible and external_owner and not external_inventory.visible:
			set_external_inventory(external_owner)
	else:
		visible = not visible
		if grabbed_slot_data:
			drop_slot_data.emit(grabbed_slot_data)
			grabbed_slot_data = null
			update_grabbed_slot()
		if visible:
			if external_owner:
				set_external_inventory(external_owner)
		else:
			on_toggle_slot_info()
			clear_external_inventory()

func set_player_inventory_data(inventory_data: InventoryData) -> void:
	inventory_data.inventory_interact.connect(on_inventory_interact)
	inventory_data.toggle_slot_info.connect(on_toggle_slot_info)
	player_inventory.set_inventory_data(inventory_data)

func set_player_equipment_data(equipment_data: InventoryData) -> void:
	equipment_data.inventory_interact.connect(on_inventory_interact)
	equipment_data.toggle_slot_info.connect(on_toggle_slot_info)
	player_equipment.set_inventory_data(equipment_data)

func set_external_inventory(_external_inventory_owner) -> void:
	external_inventory_owner = _external_inventory_owner
	var inventory_data: InventoryData = external_inventory_owner.inventory_data
	inventory_data.inventory_interact.connect(on_inventory_interact)
	inventory_data.toggle_slot_info.connect(on_toggle_slot_info)
	external_inventory.set_inventory_data(inventory_data)
	external_inventory.show()

func clear_external_inventory() -> void:
	if external_inventory_owner:
		var inventory_data: InventoryData = external_inventory_owner.inventory_data
		inventory_data.inventory_interact.disconnect(on_inventory_interact)
		inventory_data.toggle_slot_info.connect(on_toggle_slot_info)
		external_inventory.clear_inventory_data(inventory_data)
		external_inventory.hide()
		external_inventory_owner.clear_body()
		external_inventory_owner = null

func on_inventory_interact(inventory_data: InventoryData, index: int, button: int, type: Globals.ITEM_TYPES = Globals.ITEM_TYPES.ITEM, armour_type: Globals.ARMOUR_TYPES = Globals.ARMOUR_TYPES.BODY) -> void:
	match [grabbed_slot_data, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
			info_card.hide()
		[_, MOUSE_BUTTON_LEFT]:
			if type == Globals.ITEM_TYPES.ITEM or type == grabbed_slot_data.item_data.item_type:
				if type == Globals.ITEM_TYPES.ARMOUR:
					if armour_type == grabbed_slot_data.item_data.armour_type:
						grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data, index)
				else:
					grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data, index)
		[null, MOUSE_BUTTON_RIGHT]:
			# Grab half of slot stack (full grab if quantity = 1)
			pass
		[_, MOUSE_BUTTON_RIGHT]:
			grabbed_slot_data = inventory_data.drop_single_slot_data(grabbed_slot_data, index)
	update_grabbed_slot()

func on_toggle_slot_info(slot_data: SlotData = null) -> void:
	for child in info_card.get_children():
		info_card.remove_child(child)
	info_card.hide()
	if slot_data:
		var item_data = slot_data.item_data
		var card = item_data.item_card.instantiate()
		info_card.add_child(card)
		card.set_info(item_data)
		info_card.show()

func update_grabbed_slot() -> void:
	grabbed_slot.hide()
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and event.is_pressed() \
			and grabbed_slot_data:
		
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				drop_slot_data.emit(grabbed_slot_data)
				grabbed_slot_data = null
		
		update_grabbed_slot()
