extends Number
class_name MultiplyNumber

## Returns the result of multiplying one number with another.

## Number to multiply with.
@export var x: Number
## Number to multiply by.
@export var y: Number


func execute() -> float:
	return x.execute() * y.execute()
