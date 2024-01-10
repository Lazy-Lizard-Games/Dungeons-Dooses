extends EntityAction
class_name RemoveResourceAction

## Name of stacking resource to revoke from the entity.
@export var name: String
## Number of stacks to remove.
@export var number: NumberProvider


func execute(entity: Entity) -> void:
	var res: StackingResource
	for r in entity.action_component.resources:
		if r.name == name:
			res = r
	if res:
		executed = true
		res.remove_stack(number.execute())

