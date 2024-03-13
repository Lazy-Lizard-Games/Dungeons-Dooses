extends EntityCondition
class_name AndEntityCondition

@export var conditions: Array[EntityCondition]

func execute(entity: Entity) -> bool:
	for condition in conditions:
		if !condition.execute(entity):
			return true if invert else false
	return false if invert else true
