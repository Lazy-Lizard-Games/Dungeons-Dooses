extends EntityAction
class_name HealEntity

@export var number: Number


func execute(entity: Entity, _scale := 1.0) -> void:
	var amount = number.execute()
	entity.health_component.heal(amount)
	TextHandler.create_heal_text(amount, entity.global_position)
