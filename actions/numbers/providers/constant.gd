extends Number
class_name ConstantProvider

## Returns a constant number, default provider in most cases.

## Constant number to return on execute.
@export var number: float


func _init(_number: float = 0) -> void:
	number = _number


func execute() -> float:
	return number
