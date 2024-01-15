extends BientityAction
class_name DamageBientityAction

## Damage to be dealt to the target.
@export var damage: DamageEntityAction


func execute(actor: Entity, target: Entity) -> void:
	if condition:
		if !condition.execute(actor, target):
			return
	## Apply actor affinity bonuses.
	var affinities = actor.affinities
	var damage_affinity = affinities.get_damage_affinity(damage.type)
	var modifier = ConstantProvider.new(1)
	if damage_affinity:
		modifier.number = 1 + damage_affinity.get_final_value()
	var multiplier = MultiplicationOperator.new(damage.amount.duplicate(true), modifier)
	damage.amount = multiplier
	damage.execute(target)
