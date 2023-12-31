extends ModifyEntity
class_name ModifyGeneric

## Generic type to be modified.
@export var type: Enums.GenericType


func execute(entity: Entity) -> void:
	if condition:
		if !condition.execute(entity):
			return
	if !entity.generic_attributes:
		return
	var attribute = entity.generic_attributes.get_generic(type)
	if !attribute:
		return
	if should_add:
		attribute.add_modifier(modifier)
	else:
		attribute.remove_modifier(modifier)
