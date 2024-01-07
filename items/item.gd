extends Resource
class_name Item

## Type of the item.
@export var type = Enums.ItemType.Item
## Name of the item.
@export var name: String
## Description of the item.
@export_multiline var description: String
## Icon of the item.
@export var icon: Image
## Maximum stack size of the item.
@export var max_stack: int = 1
