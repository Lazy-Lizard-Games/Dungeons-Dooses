extends Node
class_name InventoryComponent

## Inventory data.
@export var inventory: InventoryData

## Attempts to store the picked up item in the inventory.
func pickup_item(item: ItemData, count: int) -> void:
	for i in range(inventory.slots.size()):
		var slot = inventory.slots[i]
		if slot and slot.item:
			if slot.item.id != item.id:
				continue
			count = stack_items(slot, count)
			if count == 0:
				break
			continue
		slot = SlotData.new()
		slot.item = item
		slot.stack = count
		inventory.slots[i] = slot
		break
	for slot in inventory.slots:
		if slot && slot.item && slot.item.id == item.id:
			print("%s - %s/%s" % [item.id, slot.stack, item.max_stack])

## Adds count to the slot at index.
func stack_items(slot: SlotData, count: int) -> int:
	var rem = (slot.stack + count) - slot.item.max_stack
	if rem < 0:
		slot.stack = slot.item.max_stack + rem
		return 0
	slot.stack = slot.item.max_stack
	return rem
