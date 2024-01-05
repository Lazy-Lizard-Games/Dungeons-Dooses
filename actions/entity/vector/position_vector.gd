extends VectorAction
class_name PositionVector

## Returns the position of the entity.


func get_vector(entity: Entity) -> Vector2:
	return entity.global_position
