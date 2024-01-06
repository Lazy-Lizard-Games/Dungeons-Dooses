extends Node
class_name InventoryComponent

## Inventory for storing items.
@export var inventory: Inventory = Inventory.new():
	set(i):
		inventory = i
		inventory.updated.emit()
