extends Item
class_name Consumable

## Cooldown before item can be consumed again.
@export var cooldown: Number
## Actions to execute on entity when consumed.
@export var actions_on_consume: Array[EntityAction]

var cooldown_timer: Timer
var can_consume := true


func get_item_type():
	return Enums.ItemType.Consumable


## Attempts to consume the item and returns the result.
func consume(entity: Entity) -> bool:
	if !can_consume:
		return false
	can_consume = false
	cooldown_timer = Timer.new()
	cooldown_timer.one_shot = true
	cooldown_timer.timeout.connect(
		func():
			entity.remove_child(cooldown_timer)
			can_consume = true
	)
	entity.add_child(cooldown_timer)
	cooldown_timer.start(cooldown.execute())
	for action in actions_on_consume:
		action.execute(entity)
	return true

