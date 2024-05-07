class_name SubtractNumber
extends Number

## Returns the result of subtracting one number by another.

## Number to subtract from.
@export var x: Number
## Number to subtract by.
@export var y: Number

func get_number() -> float:
	return x.get_number() - y.get_number()
