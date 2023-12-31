extends EntityAction
class_name TimedEntityAction

## Executes a modify action at the start and removes it at the end of the duration.

## Action to execute on entity over time.
@export var modify_action: ModifyEntity
## Duration of timed action.
@export var duration: float


func execute(entity: Entity) -> void:
	if condition:
		if !condition.execute(entity):
			return
	if duration <= 0:
		return
	modify_action.execute(entity)
	var timer = Timer.new()
	timer.timeout.connect(
		func():
			entity.remove_child(timer)
			modify_action.should_add = not modify_action.should_add
			modify_action.execute(entity)
			modify_action.should_add = not modify_action.should_add
	)
	entity.add_child(timer)
	timer.start(duration)
