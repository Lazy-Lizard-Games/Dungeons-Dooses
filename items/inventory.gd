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
