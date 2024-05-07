extends ItemAction
class_name DropItemAction

## Drops item in a lootbog at the position of the entity.

## Amount of the item to drop.
@export var amount: int

var lootbag_scene = load("res://interactables/lootbag/lootbag.tscn")


func execute(entity: Entity, item: Item) -> void:
	var lootbag = lootbag_scene.instantiate() as Lootbag
	lootbag.amount = amount
	lootbag.item = item
	lootbag.global_position = entity.global_position
	entity.get_tree().root.add_child(lootbag)
