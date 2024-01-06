extends ItemAction
class_name PickupItemAction

## Attempts to add the item to the entitites inventory.

@export var amount: int = 1


func execute(entity: Entity, item: Item) -> void:
	if entity_condition:
		if !entity_condition.execute(entity):
			return
	if item_condition:
		if !item_condition.execute(item):
			return
	if "inventory_component" in entity:
		var inventory = entity.inventory_component.inventory as Inventory
		for slot in inventory.slots:
			if slot and slot.item.name == item.name:
				amount = slot.add_stack(amount)
				if amount == 0:
					return
		for slot in inventory.slots:
			if !slot:
				var temp_slot = Slot.new()
				temp_slot.item = item
				temp_slot.stack = 0
				amount = temp_slot.add_stack(amount)
				inventory.slots[inventory.slots.find(slot)] = temp_slot
				if amount == 0:
					return
	var drop_item = DropItemAction.new()
	drop_item.amount = amount
	drop_item.execute(entity, item)
