extends StackingResource
class_name StackingModifyGeneric

## Used to apply a generic modifier that scales with stacks.

## Generic type to modify.
@export var type: Enums.GenericType
## Operation type to apply the modifier by.
@export var operation: Enums.OperationType
## Value to modify per stack.
@export var value: float

var modify: ModifyGeneric
var modifier: AttributeModifier


func start(entity: Entity) -> void:
	super(entity)
	modifier = AttributeModifier.new()
	modifier.operation = operation
	modifier.value = value * stacks
	modify = ModifyGeneric.new()
	modify.type = type
	modify.modifier = modifier
	modify.execute(entity)


func end(entity: Entity) -> void:
	modify.is_add = false
	modify.execute(entity)
	super(entity)


func add_stack(amount: int = 1) -> void:
	super(amount)
	modifier.value = value * stacks


func remove_stack(amount: int = 1) -> void:
	super(amount)
	modifier.value = value * stacks
