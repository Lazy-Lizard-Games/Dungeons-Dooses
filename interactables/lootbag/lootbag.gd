extends Interactable
class_name Lootbag

@export var item: Item
@export var amount: int = 1


func interacted(entity: Entity) -> void:
	var pickup = PickupItemAction.new()
	pickup.amount = amount
	pickup.execute(entity, item)
	queue_free()
