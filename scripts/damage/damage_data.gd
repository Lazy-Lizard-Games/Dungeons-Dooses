class_name DamageData
extends Resource

## Keeps track of anything importnatn for communicating damage.

## The amount of damage to be dealt.
@export var amount: float
## The type of the damage being dealt.
@export var type: Enums.DamageType

func _init(new_amount: float=0, new_type: Enums.DamageType=Enums.DamageType.Blunt):
	amount = new_amount
	type = new_type