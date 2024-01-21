extends Number
class_name ConstantNumber

## Returns a constant number.

## Constant to return.
@export var constant: float


func execute() -> float:
	return constant if constant else 0.0
