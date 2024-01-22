extends Item
class_name Equipment

## Type of equipment.
@export var type: Enums.EquipmentType
## Actions executed on entity when equipped.
@export var actions_on_equip: Array[EntityAction]


func get_item_type():
	return Enums.ItemType.Equipment


func equip(entity: Entity) -> void:
	for action in actions_on_equip:
		action.execute(entity)


func unequip(entity: Entity) -> void:
	for action in actions_on_equip:
		action.reverse(entity)

