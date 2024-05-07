extends Vector
class_name LookingAtVector

## Returns direction that the entity is looking at.


func get_vector(entity: Entity) -> Vector2:
	return entity.looking_at
