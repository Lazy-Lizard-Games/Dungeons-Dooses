extends Number
class_name DivisionOperator

## Returns the result of dividing one number by another.

## Number to divide from.
@export var x: Number
## Number to divide by.
@export var y: Number


func execute() -> float:
	var _y = y.execute()
	if _y == 0:
		return 0
	return x.execute() / _y.execute()
