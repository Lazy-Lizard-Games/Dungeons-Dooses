extends BientityAction
class_name AddBientityResourceAction

## Stacking resource to add stacks to on the entity.
@export var resource: StackingBientityResource
## Number of stacks to add if it already exists.
@export var number: NumberProvider


func execute(actor: Entity, target: Entity) -> void:
	if condition:
		if !condition.execute(actor, target):
			return
	executed = true
	var res: StackingBientityResource
	for r in target.action_component.resources:
		if r.name == resource.name:
			res = r
	if res:
		res.add_stack(int(number.execute()))
	else:
		res = resource.duplicate(true) as StackingBientityResource
		target.action_component.add_resource(res)
		res.start(actor, target)


func reverse(actor: Entity, target: Entity) -> void:
	if !executed:
		return
	var revoke_resource = RevokeBientityResourceAction.new()
	revoke_resource.resource = resource
	revoke_resource.execute(actor, target)

