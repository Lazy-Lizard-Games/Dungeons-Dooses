extends BientityAction
class_name RevokeBientityResourceAction

## Name of stacking resource to revoke from the entity.
@export var name: String


func execute(actor: Entity, target: Entity, _scale := 1.0) -> void:
	if condition:
		if !condition.execute(actor, target):
			return
	var res: StackingBientityResource
	for r in target.action_component.resources:
		if r.name == name:
			res = r
	if res:
		res.end(actor, target)
		target.action_component.remove_resource(res)

