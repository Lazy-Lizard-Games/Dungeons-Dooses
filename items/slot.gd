extends Resource
class_name Slot

signal updated

@export var item: Item:
	set(i):
		item = i
		updated.emit()
@export var stack: int:
	set(s):
		stack = s
		updated.emit()


## Attempts to add the amount to the stack and returns any left over.
func add_stack(amount: int) -> int:
	var space = item.max_stack - stack
	stack = clamp(stack + amount, 0, item.max_stack)
	return max(amount - space, 0)
