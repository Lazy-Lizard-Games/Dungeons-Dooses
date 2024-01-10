extends NumberProvider
class_name ConstantNumberProvider

## Returns a constant number, default provider in most cases.

## Constant number to return on execute.
@export var number: float


func execute() -> float:
	return number
