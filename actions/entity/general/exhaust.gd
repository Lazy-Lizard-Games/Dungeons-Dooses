extends EntityAction
class_name ExhaustEntityAction

@export var amount: Number

func execute(entity: Entity, scale:=1.0) -> void:
	if 'stamina_component' in entity:
		entity.stamina_component.exhaust(amount.get_number() * scale)
