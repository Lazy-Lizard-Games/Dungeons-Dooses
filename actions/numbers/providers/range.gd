extends Number
class_name RangeProvider

## Returns a random number between two numbers.

## Minimum number.
@export var number_min: float
## Maximum number.
@export var number_max: float


func execute() -> float:
	return randf_range(number_min, number_max)
