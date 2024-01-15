extends Number
class_name MultiplicationOperator

## Multiplies two numbers together and returns the result.

## First number to multiply.
@export var x: Number
## Second number to multiply.
@export var y: Number


func _init(_x: Number = ConstantProvider.new(1), _y: Number = ConstantProvider.new(1)) -> void:
	x = _x
	y = _y


func execute() -> float:
	return x.execute() * y.execute()
