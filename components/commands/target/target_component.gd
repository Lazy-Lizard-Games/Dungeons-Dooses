extends ShapeCast2D
class_name TargetComponent

## Returns a target for the entity, or null if none.
## Optionally allows for allies to be targetted.
func get_target(entity: Entity, target_allies := false) -> Entity:
	force_shapecast_update()
	for i in range(get_collision_count()):
		var body = get_collider(i)
		if body is Entity:
			if body == entity or (!target_allies and body.faction == entity.faction):
				continue
			return body
	return null

