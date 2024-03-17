extends EntityAction
class_name DamageEntityAction

## Deals damage to an entity.

## Type of damage to deal.
@export var type: Enums.DamageType
## Amount of damage to deal.
@export var amount: Number

func execute(entity: Entity, scale:=1.0) -> void:
	if condition:
		if !condition.execute(entity):
			return
	## Check if entity has health
	if "health_component" in entity:
		## Apply entity resistance bonuses.
		var amount_multiple := MultiplyNumber.new()
		amount_multiple.x = amount
		amount_multiple.y = ConstantNumber.new(entity.resistances.get_resistance(Enums.ResistanceType.Damage, type).get_final_value() * scale)
		## Apply final damage.
		var final_amount = amount_multiple.execute()
		var health = entity.health_component as HealthComponent
		health.damage(type, final_amount)
		TextHandler.create_damage_text(type, final_amount, entity.global_position)
