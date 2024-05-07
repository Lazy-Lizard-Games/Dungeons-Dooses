extends EntityAction
class_name ExhaustEntityAction

@export var amount: Number

func _init(amount_in:=0.0):
	amount = ConstantNumber.new(amount_in)

func execute(entity: Entity, scale:=1.0) -> void:
	if 'stamina_component' in entity:
		entity.stamina_component.exhaust(amount.get_number() * scale)
