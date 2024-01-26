extends EntityAction
class_name RemoveGenericModifierEntityAction

## Removes a modifier from a generic attribute.

## Attribute modifier to remove from generic attribute.
@export var uid: String
## Generic type.
@export var generic_type: Enums.GenericType


func execute(entity: Entity, _scale := 1.0) -> void:
	entity.generics.remove_modifier(generic_type, uid)
