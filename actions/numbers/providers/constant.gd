class_name ConstantNumber
extends Number

## Returns a constant number.

## Constant to return.
@export var x: float

func _init(_x:=1.0):
	x = _x

func get_number() -> float:
	return x
