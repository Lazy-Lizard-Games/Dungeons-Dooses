extends EntityAction
class_name HealEntity

@export var number: Number


func execute(entity: Entity) -> void:
	var amount = number.execute()
	entity.health_component.heal(amount)
	TextHandler.create_damage_text(Enums.DamageType.Light, amount, entity.global_position)
