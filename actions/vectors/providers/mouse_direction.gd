extends Vector
class_name MouseDirectionVector

## Returns the direction to the mouse from the entity.

func get_vector(entity: Entity) -> Vector2:
	return (entity.global_position + entity.position_offset).direction_to(entity.get_global_mouse_position())
