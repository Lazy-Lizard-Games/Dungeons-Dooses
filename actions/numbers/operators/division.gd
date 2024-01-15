extends Number
class_name DivisionOperator

## Divides two numbers together and returns the result, or zero if division by zero.

## Numerator.
@export var x: Number
## Denominator.
@export var y: Number


func execute() -> float:
	var _y = y.execute()
	if _y == 0:
		return 0
	return x.execute() / _y.execute()
