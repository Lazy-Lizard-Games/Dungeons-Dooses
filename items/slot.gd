extends Resource
class_name Slot

signal updated

## Type of item that is accepted by this slot. `Item` permits any item.
@export var type: Enums.ItemType = Enums.ItemType.Item
## Item that is loaded into the slot.
@export var item: Item = null
## Stack of the item that is loaded in the slot
@export var stack: int = 0


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
