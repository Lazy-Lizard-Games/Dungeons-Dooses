extends EntityAction
class_name CooldownEntity

@export var duration: float
@export var action_on_start: EntityAction
@export var action_on_end: EntityAction


func execute(entity: Entity) -> void:
	var cooldown_timer = Timer.new()
	cooldown_timer.timeout.connect(
		func():
			if action_on_end:
				action_on_end.execute(entity)
			entity.remove_child(cooldown_timer)
	)
	entity.add_child(cooldown_timer)
	if action_on_start:
		action_on_start.execute(entity)
	cooldown_timer.start(duration)
