extends EntityCondition
class_name HasResourceEntityCondition

## Compares the stacks of the resource to a number.

@export var name: String


func execute(entity: Entity) -> bool:
	for resource in entity.action_component.resources:
		if resource.name == name:
			return true
	return false
