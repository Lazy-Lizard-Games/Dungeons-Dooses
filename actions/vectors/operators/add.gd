extends Vector
class_name AddVector

## Returns the result of adding one vector with another.

## Vector to add to.
@export var vector_a: Vector
## Vector to add by.
@export var vector_b: Vector


func get_vector(entity: Entity) -> Vector2:
	return vector_a.get_vector(entity) + vector_b.get_vector(entity)
