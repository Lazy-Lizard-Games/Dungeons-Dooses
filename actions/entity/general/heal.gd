extends EntityAction
class_name HealEntity

@export var amount: Number

func execute(entity: Entity, _scale:=1.0) -> void:
	var final_amount = amount.get_number()
	entity.health_component.heal(final_amount)
	TextHandler.create_heal_text(final_amount, entity.global_position)
