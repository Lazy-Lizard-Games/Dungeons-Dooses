extends Vector
class_name MultiplyVector

## Returns the result of multiplying one vector with another.

## Vector to multiply with.
@export var vector_a: Vector
## Vector to multiply by.
@export var vector_b: Vector


func get_vector(entity: Entity) -> Vector2:
	return vector_a.get_vector(entity) * vector_b.get_vector(entity)
