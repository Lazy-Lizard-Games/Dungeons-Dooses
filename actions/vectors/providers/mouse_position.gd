extends Vector
class_name MousePositionVector

## Returns the position of the mouse.


func get_vector(entity: Entity) -> Vector2:
	return entity.get_global_mouse_position()
