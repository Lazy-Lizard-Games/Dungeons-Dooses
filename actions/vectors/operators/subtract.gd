extends Vector
class_name SubtractVector

## Returns the result of subtracting one vector from another.

## Vector to subtract from.
@export var vector_a: Vector
## Vector to subtract by.
@export var vector_b: Vector


func get_vector(entity: Entity) -> Vector2:
	return vector_a.get_vector(entity) - vector_b.get_vector(entity)
