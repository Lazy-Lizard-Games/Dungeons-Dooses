extends MarginContainer
class_name MenuComponent

@export var inventory_component: InventoryComponent
@export var entity: Entity

@onready var equipment_grid_container: GridContainer = $HSplitContainer/Equipment/MarginContainer/GridContainer
@onready var inventory_grid_container: GridContainer = $HSplitContainer/Inventory/MarginContainer/GridContainer
@onready var grabbed_slot_container: SlotContainer = $SlotContainer

var slot_container_scene = preload("res://components/ui/slot/slot_container.tscn")
var grabbed_slot: Slot = Slot.new()


func _ready() -> void:
	grabbed_slot.updated.connect(update_grabbed_slot)
	update_inventory()
	grabbed_slot_container.slot = grabbed_slot
	inventory_component.inventory.updated.connect(update_inventory)


func _process(_delta: float) -> void:
	if grabbed_slot.item:
		grabbed_slot_container.global_position = get_global_mouse_position()
		grabbed_slot_container.global_position -= grabbed_slot_container.custom_minimum_size/2


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		match [grabbed_slot.item, event.button_index]:
			[null, _]:
				return
			[_, MOUSE_BUTTON_LEFT]:
				var drop_item = DropItemAction.new()
				drop_item.amount = grabbed_slot.stack
				drop_item.execute(entity, grabbed_slot.item)
				grabbed_slot.set_slot(null, 0)
				return


func update_grabbed_slot() -> void:
	grabbed_slot_container.hide()
	grabbed_slot_container.update_slot()
	if grabbed_slot.item:
		grabbed_slot_container.global_position = get_global_mouse_position()
		grabbed_slot_container.show()
	


func update_inventory() -> void:
	for child in inventory_grid_container.get_children():
		child.queue_free()
	for child in equipment_grid_container.get_children():
		child.queue_free()
	var inventory = inventory_component.inventory
	var index = 0
	for slot in inventory.slots.slice(0, 6):
		var slot_container = slot_container_scene.instantiate() as SlotContainer
		slot_container.slot = slot
		slot_container.index = index
		slot_container.clicked.connect(on_slot_clicked)
		equipment_grid_container.add_child(slot_container)
		index += 1
	for slot in inventory.slots.slice(6):
		var slot_container = slot_container_scene.instantiate() as SlotContainer
		slot_container.slot = slot
		slot_container.index = index
		slot_container.clicked.connect(on_slot_clicked)
		inventory_grid_container.add_child(slot_container)
		index += 1


func on_slot_clicked(slot: Slot, index: int, button: MouseButton) -> void:
	var inventory = inventory_component.inventory
	match [grabbed_slot.item, slot.item, button]:
		[null, null, _]:
			return
		[null, _, MOUSE_BUTTON_LEFT]:
			if slot.type in Enums.equipment:
				slot.item.unequip(entity)
			grabbed_slot.set_slot(slot.item, slot.stack)
			slot.set_slot(null, 0)
			return
		[null, _, MOUSE_BUTTON_RIGHT]:
			grabbed_slot.set_slot(slot.item, ceilf(slot.stack/2.0))
			if slot.remove_stack(grabbed_slot.stack) != 0:
				if slot.type in Enums.equipment:
					slot.item.unequip(entity)
				slot.set_slot(null, 0)
				
			return
		[_, null, MOUSE_BUTTON_LEFT]:
			if slot.type == Enums.ItemType.Item or slot.type == grabbed_slot.item.type:
				slot.set_slot(grabbed_slot.item, grabbed_slot.stack)
				grabbed_slot.set_slot(null, 0)
				if slot.type in Enums.equipment:
					slot.item.equip(entity)
			return
		[_, null, MOUSE_BUTTON_RIGHT]:
			if slot.type == Enums.ItemType.Item or slot.type == grabbed_slot.item.type:
				slot.set_slot(grabbed_slot.item, 1)
				if grabbed_slot.remove_stack(1) != 0:
					grabbed_slot.set_slot(null, 0)
				if slot.type in Enums.equipment:
					slot.item.equip(entity)
			return
		[_, _, MOUSE_BUTTON_LEFT]:
			if grabbed_slot.item.name == slot.item.name:
				grabbed_slot.set_stack(inventory.get_slot(index).add_stack(grabbed_slot.stack))
				if grabbed_slot.stack == 0:
					grabbed_slot.set_slot(null, 0)
			return
		[_, _, MOUSE_BUTTON_RIGHT]:
			if slot.item and grabbed_slot.item.name == slot.item.name:
				grabbed_slot.remove_stack(1 - inventory.get_slot(index).add_stack(1))
				if grabbed_slot.stack == 0:
					grabbed_slot.set_slot(null, 0)
			return
