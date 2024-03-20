class_name MultiplyNumber
extends Number

## Returns the result of multiplying one number with another.

## Number to multiply with.
@export var x: Number
## Number to multiply by.
@export var y: Number

func get_number() -> float:
	return x.get_number() * y.get_number()
