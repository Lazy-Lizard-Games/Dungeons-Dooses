extends Resource
class_name SlotData

const MAX_STACK_SIZE: int = 99

@export var item_data: ItemData
@export_range(1, MAX_STACK_SIZE) var quantity: int = 1: set = set_quantity

func can_merge_with(other_slot_data: SlotData) -> bool:
	return item_data == other_slot_data.item_data \
			and item_data.stackable \
			and quantity < MAX_STACK_SIZE

func merge_with(other_slot_data: SlotData) -> SlotData:
	quantity += other_slot_data.quantity
	if quantity > MAX_STACK_SIZE:
		other_slot_data.quantity = quantity - MAX_STACK_SIZE
		quantity = MAX_STACK_SIZE
		return other_slot_data
	return null

func create_single_slot_data() -> SlotData:
	var new_slot_data = duplicate()
	new_slot_data.quantity = 1
	quantity -= 1
	return new_slot_data

func set_quantity(value: int) -> void:
	quantity = value
	if quantity > 1 and not item_data.stackable:
		push_error("%s is not stackable, setting quantity to 1" % item_data.name)
		quantity = 1
