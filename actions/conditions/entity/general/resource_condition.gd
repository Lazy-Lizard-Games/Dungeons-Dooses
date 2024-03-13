extends EntityCondition
class_name ResourceEntityCondition

## Compares the stacks of the resource to a number.

@export var name: String
@export var compare_to: Number
@export var comparison: ComparisonProvider

func execute(entity: Entity) -> bool:
	for resource in entity.action_component.resources:
		if resource.name == name:
			if comparison.execute(resource.stacks, compare_to.execute()):
				return false if invert else true
	return true if invert else false
