class_name DivideNumber
extends Number

## Returns the result of dividing one number by another.

## Number to divide from.
@export var x: Number
## Number to divide by.
@export var y: Number

func get_number() -> float:
	var _y = y.get_number()
	if _y == 0:
		return 0
	return x.get_number() / _y.get_number()
