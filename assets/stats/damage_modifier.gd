extends Resource
class_name DamageModifier

## Type of damage
@export var type: Globals.DAMAGE_TYPES
## Percentage modifier
@export var value: float = 0

func get_type() -> Globals.DAMAGE_TYPES:
	return type

func get_value() -> float:
	return value
