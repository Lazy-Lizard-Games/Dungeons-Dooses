extends MarginContainer
class_name MenuComponent

@export var inventory_component: InventoryComponent

@onready var inventory_grid_container: GridContainer = $HSplitContainer/Inventory/MarginContainer/GridContainer
@onready var grabbed_slot_container: SlotContainer = $SlotContainer

var slot_container_scene = preload("res://components/ui/slot/slot_container.tscn")
var grabbed_slot: Slot = null:
	set(s):
		grabbed_slot = s
		grabbed_slot_container.hide()
		if grabbed_slot:
			grabbed_slot_container.global_position = get_global_mouse_position()
			grabbed_slot_container.show()
		if grabbed_slot_container:
			grabbed_slot_container.slot = grabbed_slot


func _ready() -> void:
	update_inventory()
	grabbed_slot_container.slot = grabbed_slot
	inventory_component.inventory.updated.connect(update_inventory)


func _process(_delta: float) -> void:
	if grabbed_slot:
		grabbed_slot_container.global_position = get_global_mouse_position()
		grabbed_slot_container.global_position -= grabbed_slot_container.custom_minimum_size/2


func update_inventory() -> void:
	for child in inventory_grid_container.get_children():
		child.queue_free()
	var inventory = inventory_component.inventory
	var index = 0
	for slot in inventory.slots:
		var slot_container = slot_container_scene.instantiate() as SlotContainer
		slot_container.slot = slot
		slot_container.index = index
		slot_container.clicked.connect(on_slot_clicked)
		inventory_grid_container.add_child(slot_container)
		index += 1


func on_slot_clicked(slot: Slot, index: int, button: MouseButton) -> void:
	var inventory = inventory_component.inventory
	match [grabbed_slot, slot, button]:
		[null, null, _]:
			return
		[null, _, MOUSE_BUTTON_LEFT]:
			grabbed_slot = slot
			inventory.set_slot(index, null)
			return
		[null, _, MOUSE_BUTTON_RIGHT]:
			var temp_slot = Slot.new()
			temp_slot.item = slot.item
			temp_slot.stack = ceilf(slot.stack/2.0)
			@warning_ignore("narrowing_conversion")
			slot.stack = floorf(slot.stack/2.0)
			grabbed_slot = temp_slot
			if slot.stack == 0:
				inventory.set_slot(index, null)
			return
		[_, null, MOUSE_BUTTON_LEFT]:
			inventory.set_slot(index, grabbed_slot)
			grabbed_slot = null
			return
		[_, null, MOUSE_BUTTON_RIGHT]:
			var temp_slot = Slot.new()
			temp_slot.item = grabbed_slot.item
			temp_slot.stack = 1
			inventory.set_slot(index, temp_slot)
			grabbed_slot.stack -= 1
			if grabbed_slot.stack == 0:
				grabbed_slot = null
			grabbed_slot_container.update_slot()
			return
		[_, _, MOUSE_BUTTON_LEFT]:
			if grabbed_slot.item.name == slot.item.name:
				grabbed_slot.stack = inventory.get_slot(index).add_stack(grabbed_slot.stack)
				grabbed_slot_container.update_slot()
				if grabbed_slot.stack == 0:
					grabbed_slot = null
			return
		[_, _, MOUSE_BUTTON_RIGHT]:
			if grabbed_slot.item.name == slot.item.name:
				grabbed_slot.stack -= 1 - inventory.get_slot(index).add_stack(1)
				grabbed_slot_container.update_slot()
				if grabbed_slot.stack == 0:
					grabbed_slot = null
			return
