extends Vector
class_name VelocityVector

## Returns the velocity of the entity.


func get_vector(entity: Entity) -> Vector2:
	return entity.velocity_component.velocity
