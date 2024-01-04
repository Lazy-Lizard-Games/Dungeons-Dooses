extends EntityAction
class_name AddResourceAction

## Stacking resource to add stacks to on the entity.
@export var resource: StackingResource
## Amount of stacks to add.
@export var amount: int = 1


func execute(entity: Entity) -> void:
	var res: StackingResource
	for r in entity.action_component.resources:
		if r.name == resource.name:
			res = r
	if res:
		res.add_stack(amount)
	else:
		res = resource.duplicate() as StackingResource
		entity.action_component.resources.append(res)
		res.stacks = amount
		res.start(entity)
