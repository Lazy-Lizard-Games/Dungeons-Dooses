extends Node
class_name InventoryComponent

## Inventory for storing items.
@export var inventory: Inventory = Inventory.new():
	set(i):
		inventory = i
		inventory.updated.emit()


func _ready() -> void:
	for i in range(inventory.slots.size()):
		if !inventory.slots[i]:
			inventory.slots[i] = Slot.new()
