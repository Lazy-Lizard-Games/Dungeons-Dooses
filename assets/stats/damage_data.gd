extends Resource
class_name DamageData

## Flat damage
@export var damage: float = 0 :
	get:
		return damage
	set(value):
		damage = value
## Type of the damage, affected by resistances and multipliers
@export var type: Globals.DAMAGE_TYPES:
	get:
		return type

func copy() -> DamageData:
	var copy = DamageData.new()
	copy.damage = damage
	copy.type = type
	return copy
