extends Resource
class_name ItemData

@export var item_name: String = ""
@export_multiline var description: String = ""
@export var stackable: bool = false
@export var texture: AtlasTexture

var item_card: PackedScene
var item_type: Globals.ITEM_TYPES

func _init() -> void:
	setup()

func setup() -> void:
	item_type = Globals.ITEM_TYPES.ITEM
	item_card = preload("res://scenes/inventory/info_cards/item_card.tscn")

func get_item_name() -> String:
	return item_name

func get_description()-> String:
	return description
