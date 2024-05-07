extends Resource
class_name AttributeModifier

@export var uid: StringName
@export var operation: Enums.OperationType
@export var value: float

func _init(new_uid:=&"_", new_operation:=Enums.OperationType.Addition, new_value:=0.0) -> void:
	uid = new_uid
	operation = new_operation
	value = new_value
