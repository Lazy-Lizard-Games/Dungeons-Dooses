extends BientityAction
class_name DamageAction

## Damage type to be dealt to the target.
@export var type: Enums.DamageType
## Amount of damage to be dealth to the target.
@export var amount: float


func execute(actor: Entity, target: Entity) -> void:
	if condition:
		if !condition.execute(actor, target):
			return
	var temp_amount = amount
	## Apply actor affinity bonuses.
	if "affinity_attributes" in actor:
		var affinities = actor.affinity_attributes as AffinityAttributes
		var affinity = affinities.get_affinity(type)
		if affinity:
			temp_amount += temp_amount * affinity.get_final_value()
	## Apply target resistance bonuses.
	if "resistance_attributes" in target:
		var resistances = target.resistance_attributes as ResistanceAttributes
		var resistance = resistances.get_resistance(type)
		if resistance:
			temp_amount -= temp_amount * resistance.get_final_value()
	## Apply final damage.
	if "health_component" in target:
		var health = target.health_component as HealthComponent
		health.damage(type, temp_amount, actor)
		TextHandler.create_damage_text(type, temp_amount, target.global_position)
