@tool
extends Resource
class_name Slot

signal updated

## Type of item that is accepted by this slot. `Item` permits any item.
@export var item_type: Enums.ItemType:
	set(new_type):
		item_type = new_type
		notify_property_list_changed()
## Item that is loaded into the slot.
@export var item: Item = null
## Stack of the item that is loaded in the slot
@export var stack: int = 0
## If item type is equipment, species type of equipment.
var equipment_type: Enums.EquipmentType


func _get_property_list():
	var property_usage = PROPERTY_USAGE_NO_EDITOR
	if item_type == Enums.ItemType.Equipment:
		property_usage = PROPERTY_USAGE_DEFAULT
	var properties = []
	properties.append({
		"name": "equipment_type",
		"type": TYPE_INT,
		"usage": property_usage, # See above assignment.
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": "Ring,Necklace,Circlet,Charm"
	})
	return properties


func set_slot(new_item: Item, new_stack: int) -> void:
	set_item(new_item)
	set_stack(new_stack)


func set_item(new_item: Item) -> void:
	item = new_item
	updated.emit()


func set_stack(new_stack: int) -> void:
	stack = new_stack
	updated.emit()


## Attempts to add the amount to the stack and returns any left over.
func add_stack(amount: int) -> int:
	var space = item.max_stack - stack
	stack = min(stack + amount, item.max_stack)
	updated.emit()
	return max(amount - space, 0)

## Attempts to remove the amount from the stack and returns any left over.
func remove_stack(amount: int) -> int:
	var space = stack
	stack = max(stack - amount, 0)
	updated.emit()
	return max(amount - space, 0)
