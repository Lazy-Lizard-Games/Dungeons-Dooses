extends Number
class_name SubtractionOperator

## Returns the result of subtracting one number by another.

## Number to subtract from.
@export var x: Number
## Number to subtract by.
@export var y: Number


func execute() -> float:
	return x.execute() - y.execute()
