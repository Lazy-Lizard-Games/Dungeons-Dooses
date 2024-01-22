extends Resource
class_name Inventory

signal updated

@export var slots: Array[Slot] = []:
	set(s):
		if slots != s:
			slots = s
			updated.emit()


func set_slot(index: int, new_slot: Slot) -> void:
	if index < slots.size():
		slots[index].set_slot(new_slot.item, new_slot.stack)
		updated.emit()


func get_slot(index: int) -> Slot:
	return slots[index]


func consume_slot(index: int, entity: Entity) -> void:
	var slot = get_slot(index)
	if slot.item and slot.item is Consumable:
		if !slot.item.consume(entity):
			return
		slot.remove_stack(1)
		if slot.stack == 0:
			slot.set_slot(null, 0)
