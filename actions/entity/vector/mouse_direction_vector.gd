extends VectorAction
class_name MouseDirectionVector

## Returns the direction to the mouse from the entity.


func get_vector(entity: Entity) -> Vector2:
	return entity.global_position.direction_to(entity.get_global_mouse_position())
