extends Vector
class_name NormalizeVector

## Returns the vector after it has been normalized.

## Vector to be normalized.
@export var vector: Vector


func get_vector(entity: Entity) -> Vector2:
	return vector.get_vector(entity).normalized()
