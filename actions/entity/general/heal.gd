extends EntityAction
class_name HealEntity

@export var amount: float


func execute(entity: Entity) -> void:
	entity.health.heal(amount)
