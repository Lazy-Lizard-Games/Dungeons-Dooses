class_name DamageEntityWithTransforms
extends BientityAction

## Deals damage to the target after applying actor bonuses.`

## Type of damage to deal.
@export var type: Enums.DamageType
## Amount of damage to deal.
@export var amount: Number

func execute(actor: Entity, target: Entity, scale:=1.0) -> void:
	if condition:
		if !condition.execute(actor, target):
			return
	# Apply actor damage affinity
	var amount_multiple := MultiplyNumber.new()
	amount_multiple.x = amount
	var amount_multiplier := ConstantNumber.new()
	amount_multiplier.x = actor.affinities.get_affinity(Enums.AffinityType.Damage, type).get_final_value() * scale
	amount_multiple.y = amount_multiplier
	# # Apply damage to target
	# var damage = DamageEntity.new()
	# damage.amount = amount_multiple
	# damage.type = type
	# damage.execute(target, scale)
