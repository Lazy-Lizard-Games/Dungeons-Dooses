extends Number
class_name SubtractionOperator

## Subtracts two numbers together and returns the result.

## Number to subtract from.
@export var x: Number
## Number to subtract.
@export var y: Number


func execute() -> float:
	return x.execute() - y.execute()
