extends EntityCondition
class_name NotEntityCondition


@export var condition: EntityCondition


func execute(entity: Entity) -> bool:
	return !condition.execute(entity)
