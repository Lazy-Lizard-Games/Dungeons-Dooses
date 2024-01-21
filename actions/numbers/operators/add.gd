extends Number
class_name AddNumber

## returns the result of adding one number with another.

## Number to add to.
@export var x: Number
## Number to add by.
@export var y: Number


func execute() -> float:
	return x.execute() + y.execute()
