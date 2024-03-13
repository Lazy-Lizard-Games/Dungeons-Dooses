extends Vector
class_name ConstantVector

## Returns a constant Vector2.

## X component of the Vector2.
@export var x: Number
## Y component of the Vector2.
@export var y: Number

func _init(_x:=1.0, _y:=1.0):
	x = ConstantNumber.new(_x)
	y = ConstantNumber.new(_y)

func get_vector(_entity) -> Vector2:
	return Vector2(x.execute(), y.execute())
