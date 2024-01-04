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
		var damage_affinity = affinities.get_damage_affinity(type)
		if damage_affinity:
			temp_amount += temp_amount * damage_affinity.get_final_value()
	## Apply target resistance bonuses.
	if "resistance_attributes" in target:
		var resistances = target.resistance_attributes as ResistanceAttributes
		var damage_resistance = resistances.get_damage_resistance(type)
		if damage_resistance:
			temp_amount -= temp_amount * damage_resistance.get_final_value()
	## Apply final damage.
	if "health_component" in target:
		var health = target.health_component as HealthComponent
		health.damage(type, temp_amount, actor)
		TextHandler.create_damage_text(type, temp_amount, target.global_position)
