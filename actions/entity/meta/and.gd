extends EntityAction
class_name AndEntity

@export var actions: Array[EntityAction]


func execute(entity: Entity, scale := 1.0) -> void:
	if condition:
		if !condition.execute(entity):
			return
	for action in actions:
		action.execute(entity, scale)
