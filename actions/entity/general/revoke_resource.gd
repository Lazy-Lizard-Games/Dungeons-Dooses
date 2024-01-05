extends EntityAction
class_name RevokeResourceAction

## Stacking resource to revoke from the entity.
@export var resource: StackingResource


func execute(entity: Entity) -> void:
	var res: StackingResource
	for r in entity.action_component.resources:
		if r.name == resource.name:
			res = r
	if res:
		entity.action_component.remove_resource(res)
		res.end(entity)
