extends Number
class_name AdditionOperator

## Adds two numbers together and returns the result.

## First number to add.
@export var x: Number
## Second number to add.
@export var y: Number


func execute() -> float:
	return x.execute() + y.execute()
