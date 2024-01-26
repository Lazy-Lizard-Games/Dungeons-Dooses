extends StackingEntityAction
class_name StackingAffinityAction

## Used to apply a affinity modifier that scales with stacks.

## Unique identifier of the attribute modifier
@export var uid: String
## Affinity type to modify.
@export var affinity_type: Enums.AffinityType
## Generic type to modify.
@export var damage_type: Enums.DamageType
## Operation type to apply the modifier by.
@export var operation: Enums.OperationType
## Value to modify per stack.
@export var value: float

var add_affinity: AddAffinityModifierEntityAction
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
	add_affinity = AddAffinityModifierEntityAction.new()
	add_affinity.affinity_type = affinity_type
	add_affinity.damage_type = damage_type
	add_affinity.modifier = modifier
	add_affinity.execute(entity, scale)


func reverse(entity: Entity) -> void:
	add_affinity.reverse(entity)

