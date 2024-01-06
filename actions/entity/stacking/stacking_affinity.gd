extends StackingEntityAction
class_name StackingAffinityAction

## Used to apply a affinity modifier that scales with stacks.

## Generic type to modify.
@export var type: Enums.DamageType
## Affinity type to modify.
@export var affinity: Enums.AffinityType
## Operation type to apply the modifier by.
@export var operation: Enums.OperationType
## Value to modify per stack.
@export var value: float

var modify: ModifyAffinity
var modifier: AttributeModifier


func execute(entity: Entity) -> void:
	modifier = AttributeModifier.new()
	modifier.operation = operation
	modifier.value = value * stacks
	modify = ModifyAffinity.new()
	modify.type = type
	modify.affinity = affinity
	modify.modifier = modifier
	modify.execute(entity)


func remove(entity: Entity) -> void:
	modify.is_add = false
	modify.execute(entity)


func update_stacks(new_stacks: int) -> void:
	super(new_stacks)
	modifier.value = value * stacks
