@tool
class_name RotateVector
extends Vector

## Rotates the vector by a value somewhere between min and max.

@export var vector: Vector
@export_range(-180, 180, ) var minimum: int = 0:
	set(new_minimum):
		minimum = new_minimum
		if minimum > maximum:
			maximum = minimum
@export_range(-180, 180) var maximum: int = 0:
	set(new_maximum):
		maximum = new_maximum
		if maximum < minimum:
			minimum = maximum

func get_vector(entity: Entity) -> Vector2:
	var angle = randi_range(minimum, maximum)
	return vector.get_vector(entity).rotated(deg_to_rad(angle))
