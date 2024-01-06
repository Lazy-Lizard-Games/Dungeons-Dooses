extends EntityAction
class_name AddResourceAction

## Stacking resource to add stacks to on the entity.
@export var resource: StackingResource
## Amount of stacks to add if it already exists.
@export var amount: int = 1


func execute(entity: Entity) -> void:
	if condition:
		if !condition.execute(entity):
			return
	var res: StackingResource
	for r in entity.action_component.resources:
		if r.name == resource.name:
			res = r
	if res:
		res.add_stack(amount)
	else:
		res = resource.duplicate() as StackingResource
		entity.action_component.add_resource(res)
		res.start(entity)
