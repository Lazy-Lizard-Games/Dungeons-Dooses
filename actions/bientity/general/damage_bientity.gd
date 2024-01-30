extends BientityAction
class_name DamageBientityAction

## Damage to be dealt to the target.
@export var damage: DamageEntityAction


func execute(actor: Entity, target: Entity, scale := 1.0) -> void:
	if condition:
		if !condition.execute(actor, target):
			return
	## Apply actor affinity bonuses.
	var affinities = actor.affinities
	var damage_affinity = affinities.get_damage_affinity(damage.type)
	print(actor.name)
	var modifier = ConstantNumber.new()
	modifier.constant = 1
	if damage_affinity:
		modifier.constant = 1 + damage_affinity.get_final_value()
	var number = MultiplyNumber.new()
	number.x = damage.amount
	number.y = modifier
	var temp_damage = damage.duplicate(true)
	temp_damage.amount = number
	temp_damage.execute(target, scale)
