extends Number
class_name ConstantNumber

## Returns a constant number.

## Constant to return.
@export var constant: float

func _init(x:=1.0):
	constant = x

func execute() -> float:
	return constant if constant else 0.0
