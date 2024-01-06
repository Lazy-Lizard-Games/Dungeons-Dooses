extends Item
class_name Consumable

@export var actions_on_consume: Array[EntityAction]


func consume(entity: Entity) -> void:
	for action in actions_on_consume:
		action.execute(entity)
