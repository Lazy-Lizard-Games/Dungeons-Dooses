extends Resource
class_name ItemData

## Item type, used for slot filtering.
@export var type : Enums.ItemType
## Item name.
@export var id: String
## Item description.
@export_multiline var description: String
## Maximum items per stack.
@export var max_stack: int
## Item icon.
@export var icon: Texture2D
