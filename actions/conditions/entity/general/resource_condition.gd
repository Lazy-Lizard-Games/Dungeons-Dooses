extends EntityCondition
class_name ResourceEntityCondition

## Compares the stacks of the resource to a number.

@export var name: String
@export var compare_to: NumberProvider
@export var comparison: ComparisonProvider


func execute(entity: Entity) -> bool:
	for resource in entity.action_component.resources:
		if resource.name == name:
			if comparison.execute(resource.stacks, compare_to.execute()):
				return true
	return false
