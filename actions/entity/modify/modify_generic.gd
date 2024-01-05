extends ModifyEntity
class_name ModifyGeneric

## Generic type to be modified.
@export var type: Enums.GenericType


func execute(entity: Entity) -> void:
	if condition:
		if !condition.execute(entity):
			return
	entity.generics.modify_generic(type, modifier, is_add)
