extends Resource
class_name ItemAction

## Condition to check whether action is executed.
@export var entity_condition: EntityCondition
@export var item_condition: ItemCondition


## Executes an action on the entity and/or item.
func execute(_entity: Entity, _item: Item) -> void:
	pass
