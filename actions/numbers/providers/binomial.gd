class_name BinomialNumber
extends Number

## Returns the number of tests that pass a chance check.

## Number of iterations.
@export var n: int
## Chance that an iteration is successful
@export_range(0, 1) var p: float

func get_number() -> float:
	var count = 0
	for i in range(n):
		if randf_range(0, 1) < p:
			count += 1
	return count
