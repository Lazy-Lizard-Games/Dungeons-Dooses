extends EntityAction
class_name AddGenericModifierEntityAction

## Adds a modifier to a generic generic.

## Attribute modifier to modify generic by.
@export var modifier: AttributeModifier
## Generic type to modify.
@export var generic_type: Enums.GenericType


func execute(entity: Entity, _scale := 1.0) -> void:
	entity.generics.add_modifier(generic_type, modifier)


func reverse(entity: Entity) -> void:
	var remove_generic = RemoveGenericModifierEntityAction.new()
	remove_generic.uid = modifier.uid
	remove_generic.generic_type = generic_type
	remove_generic.execute(entity)
