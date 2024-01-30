extends EntityAction
class_name RemoveItemAction

## Removes an item action from the entity.

## Type of the item action to remove.
@export var type: Enums.ItemActionType
## Name of the item action to remove.
@export var id: String


func execute(_entity: Entity, _scale: = 1.0) -> void:
	var _actions: Array[ItemAction]
	match type:
		Enums.ItemActionType.OnConsume:
			pass
		Enums.ItemActionType.OnEquip:
			pass
	#if actions:
		#for action in actions:
			#if action.name == name:
				#actions.erase(action)
				#break
