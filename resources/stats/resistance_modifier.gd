extends Resource
class_name ResistModifier

@export var type: Globals.DAMAGE_TYPES
@export var value: int = 0

func get_type() -> Globals.DAMAGE_TYPES:
	return type

func get_value() -> int:
	return value
