extends Resource
class_name ItemData

@export var name: String = ""
@export_multiline var description: String = ""
@export var stackable: bool = false
@export var texture: AtlasTexture

var item_type: Globals.ITEM_TYPES

func _init() -> void:
	setup()

func setup() -> void:
	item_type = Globals.ITEM_TYPES.ITEM
