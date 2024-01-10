extends EntityAction
class_name RevokeResourceAction

## Name of stacking resource to revoke from the entity.
@export var name: String


func execute(entity: Entity) -> void:
	if condition:
		if !condition.execute(entity):
			return
	var res: StackingResource
	for r in entity.action_component.resources:
		if r.name == name:
			res = r
	if res:
		entity.action_component.remove_resource(res)
		res.end(entity)

