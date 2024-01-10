extends StackingEntityAction
class_name StackingResistanceAction

## Used to apply a resistance modifier that scales with stacks.

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


func execute(entity: Entity) -> void:
	modifier = AttributeModifier.new()
	modifier.operation = operation
	modifier.value = value * stacks
	modify = ModifyResistance.new()
	modify.type = type
	modify.resistance = resistance
	modify.modifier = modifier
	modify.execute(entity)


func reverse(entity: Entity) -> void:
	modify.is_add = false
	modify.execute(entity)


func update_stacks(new_stacks: int) -> void:
	super(new_stacks)
	modifier.value = value * stacks
