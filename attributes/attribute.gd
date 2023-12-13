extends Node
class_name Attribute

@export var type: Enums.AttributeType
@export var group: Enums.AttributeGroup
@export_multiline var description: String
@export var raw_value: float = 0
@export var multiplier_value: float = 1


## Returns the final attribute value after modifiers are applied.
func get_final_value() -> float:
	return raw_value * multiplier_value
