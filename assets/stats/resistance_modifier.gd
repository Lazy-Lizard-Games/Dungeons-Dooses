extends Resource
class_name ResistModifier

## Damage Type
@export var type: Globals.DAMAGE_TYPES :
	get:
		return type
## Damage multiplier, a value of 0.5 will decrease by 50% and 2.0 will increase by 100%
@export var value: float = 1 :
	get:
		return value
