extends StackingEntityAction
class_name StackingResistanceAction

## Used to apply a resistance modifier that scales with stacks.

## Unique identifier of the attribute modifier
@export var uid: String
## Resistance type to modify.
@export var resistance_type: Enums.ResistanceType
## Generic type to modify.
@export var damage_type: Enums.DamageType
## Operation type to apply the modifier by.
@export var operation: Enums.OperationType
## Value to modify per stack.
@export var value: float

var add_resistance: AddResistanceModifierEntityAction
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
	add_resistance = AddResistanceModifierEntityAction.new()
	add_resistance.resistance_type = resistance_type
	add_resistance.damage_type = damage_type
	add_resistance.modifier = modifier
	add_resistance.execute(entity, scale)


func reverse(entity: Entity) -> void:
	add_resistance.reverse(entity)
