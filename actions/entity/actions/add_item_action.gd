extends EntityAction
class_name AddItemAction

## Adds an item action to the entity.

## Type of item action to add.
@export var type: Enums.ItemActionType
## Action to add.
@export var action: ItemAction

## TODO: Implement OnConsume and OnEquip actions/triggers.

func execute(_entity: Entity, _scale:=1.0) -> void:
	match type:
		Enums.ItemActionType.OnConsume:
			pass
		Enums.ItemActionType.OnEquip:
			pass
