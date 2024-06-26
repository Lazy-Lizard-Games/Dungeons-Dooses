extends Resource
class_name Item

## Name of the item.
@export var name: String
## Description of the item.
@export_multiline var description: String
## Icon of the item.
@export var icon: Image
## Maximum stack size of the item.
@export var max_stack: int = 1
## Item type
var item_type: Enums.ItemType:
	get:
		return get_item_type()


func get_item_type():
	return Enums.ItemType.Item
