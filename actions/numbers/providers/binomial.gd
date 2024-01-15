extends Number
class_name BinomialProvider

## Returns the number of tests that pass a chance check.

## Number of iterations.
@export var n: int
## Chance that an iteration is successful
@export_range(0, 1) var p: float


func execute() -> float:
	var count = 0
	for i in range(n):
		if randf_range(0, 1) < p:
			count += 1
	return count
