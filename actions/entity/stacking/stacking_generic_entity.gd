extends StackingEntityAction
class_name StackingGenericAction

## Used to apply a generic modifier that scales with stacks.

## Unique identifier of the attribute modifier
@export var uid: String
## Generic type to modify.
@export var type: Enums.GenericType
## Operation type to apply the modifier by.
@export var operation: Enums.OperationType
## Value to modify per stack.
@export var value: float

var add_generic: AddGenericModifierEntityAction
var modifier: AttributeModifier


func execute(entity: Entity, scale := 1.0) -> void:
	modifier = AttributeModifier.new()
	modifier.uid = uid
	modifier.operation = operation
	modifier.value = value * stacks
	stacks_changed.connect(
		func():
			modifier.value = value * stacks * scale
	)
	add_generic = AddGenericModifierEntityAction.new()
	add_generic.generic_type = type
	add_generic.modifier = modifier
	add_generic.execute(entity, scale)


func reverse(entity: Entity) -> void:
	add_generic.reverse(entity)

