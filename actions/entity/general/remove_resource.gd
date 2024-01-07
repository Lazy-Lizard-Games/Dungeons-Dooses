extends EntityAction
class_name RemoveResourceAction

## Stacking resource to remove stacks from on the entity.
@export var resource: StackingResource
## Amount of stacks to remove.
@export var amount: int = 1


func execute(entity: Entity) -> void:
	var res: StackingResource
	for r in entity.action_component.resources:
		if r.name == resource.name:
			res = r
	if res:
		executed = true
		res.remove_stack(amount)


func reverse(entity: Entity) -> void:
	if !executed:
		return
	var add_resource = AddResourceAction.new()
	add_resource.resource = resource
	add_resource.amount = amount
	add_resource.execute(entity)
