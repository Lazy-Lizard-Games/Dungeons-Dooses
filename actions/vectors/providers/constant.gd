extends Vector
class_name ConstantVector

## Returns a constant Vector2.

## X component of the Vector2.
@export var x: Number
## Y component of the Vector2.
@export var y: Number


func get_vector(_entity) -> Vector2:
	return Vector2(x.execute(), y.execute())
