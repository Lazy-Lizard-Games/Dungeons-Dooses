extends Item
class_name Equipment

@export var actions_on_equip: Array[EntityAction]


func equip(entity: Entity) -> void:
	for action in actions_on_equip:
		action.execute(entity)


func unequip(entity: Entity) -> void:
	for action in actions_on_equip:
		action.reverse(entity)
