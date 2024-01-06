extends Item
class_name Equipment

@export var actions_on_equip: Array[EntityAction]
@export var actions_on_unequip: Array[EntityAction]


func equip(entity: Entity) -> void:
	for action in actions_on_equip:
		action.execute(entity)


func unequip(entity: Entity) -> void:
	for action in actions_on_unequip:
		action.execute(entity)
