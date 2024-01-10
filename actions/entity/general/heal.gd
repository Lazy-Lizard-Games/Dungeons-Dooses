extends EntityAction
class_name HealEntity

@export var number: NumberProvider


func execute(entity: Entity) -> void:
	entity.health_component.heal(number.execute())
