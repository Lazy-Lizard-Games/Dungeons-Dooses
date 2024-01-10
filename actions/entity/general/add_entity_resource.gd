extends EntityAction
class_name AddEntityResource

## Stacking resource to add stacks to on the entity.
@export var resource: StackingEntityResource
## Number of stacks to add if it already exists.
@export var number: NumberProvider


func execute(entity: Entity) -> void:
	if condition:
		if !condition.execute(entity):
			return
	executed = true
	var res: StackingEntityResource
	for r in entity.action_component.resources:
		if r.name == resource.name:
			res = r
	if res:
		res.add_stack(int(number.execute()))
	else:
		res = resource.duplicate() as StackingEntityResource
		entity.action_component.add_resource(res)
		res.start(entity)


func reverse(entity: Entity) -> void:
	if !executed:
		return
	var revoke_resource = RevokeResourceAction.new()
	revoke_resource.resource = resource
	revoke_resource.execute(entity)
