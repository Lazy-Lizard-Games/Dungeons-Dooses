extends Resource
class_name StatModifier

@export var stat: Globals.STAT_TYPES
@export var value: int = 0

func get_stat() -> String:
	return Globals.STATS[stat]

func get_value() -> int:
	return value
