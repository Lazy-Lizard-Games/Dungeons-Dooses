extends EntityAction
class_name DamageEntityAction

## Deals damage to an entity.

## Type of damage to deal.
@export var type: Enums.DamageType
## Amount of damage to deal.
@export var amount: Number


func execute(entity: Entity) -> void:
	if condition:
		if !condition.execute(entity):
			return
	var temp_amount = amount.execute()
	## Apply entity resistance bonuses.
	var resistances = entity.resistances
	var damage_resistance = resistances.get_damage_resistance(type)
	if damage_resistance:
		temp_amount *= 1.0 - damage_resistance.get_final_value()
	## Apply final damage.
	if "health_component" in entity:
		var health = entity.health_component as HealthComponent
		health.damage(type, temp_amount)
		TextHandler.create_damage_text(type, temp_amount, entity.global_position)
