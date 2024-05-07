class_name AddNumber
extends Number

## returns the result of adding one number with another.

## Number to add to.
@export var x: Number
## Number to add by.
@export var y: Number

func get_number() -> float:
	return x.get_number() + y.get_number()
