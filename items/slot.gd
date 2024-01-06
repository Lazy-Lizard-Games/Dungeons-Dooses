extends Resource
class_name Slot

@export var item: Item
@export var stack: int


## Attempts to add the amount to the stack and returns any left over.
func add_stack(amount: int) -> int:
	var space = item.max_stack - stack
	stack = min(stack + amount, item.max_stack)
	return max(amount - space, 0)
