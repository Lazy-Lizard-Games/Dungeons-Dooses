extends StackingResource
class_name StackingModifyResistance

## Used to apply a generic modifier that scales with stacks.

## Generic type to modify.
@export var type: Enums.DamageType
## Resistance type to modify.
@export var resistance: Enums.ResistanceType
## Operation type to apply the modifier by.
@export var operation: Enums.OperationType
## Value to modify per stack.
@export var value: float

var modify: ModifyResistance
var modifier: AttributeModifier


func start(entity: Entity) -> void:
	super(entity)
	modifier = AttributeModifier.new()
	modifier.operation = operation
	modifier.value = value * stacks
	modify = ModifyResistance.new()
	modify.type = type
	modify.resistance = resistance
	modify.modifier = modifier
	modify.execute(entity)


func end(entity: Entity) -> void:
	modify.should_add = false
	modify.execute(entity)
	super(entity)


func add_stack(amount: int = 1) -> void:
	super(amount)
	modifier.value = value * stacks


func remove_stack(amount: int = 1) -> void:
	super(amount)
	modifier.value = value * stacks
