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
		for slot in inventory.slots as Array[Slot]:
			if slot.item and slot.item.name == item.name:
				amount = slot.add_stack(amount)
				if amount == 0:
					return
		for slot in inventory.slots as Array[Slot]:
			if !slot.item and (slot.type == item.type or slot.type == Enums.ItemType.Item):
				if slot.type in Enums.equipment:
					item.equip(entity)
				slot.set_slot(item, 0)
				amount = slot.add_stack(amount)
				if amount == 0:
					return
	var drop_item = DropItemAction.new()
	drop_item.amount = amount
	drop_item.execute(entity, item)
