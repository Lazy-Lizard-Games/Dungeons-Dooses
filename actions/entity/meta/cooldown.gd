extends EntityAction
class_name CooldownEntity

## Triggers an action over time on the entity.

## Action to trigger when cooldown starts.
@export var action_on_start: EntityAction
## Action to trigger on every tick interval.
@export var action_on_tick: EntityAction
## Action to trigger when cooldown ends.
@export var action_on_end: EntityAction
## Duration of cooldown in seconds.
@export var duration: float
## Tick interval in seconds.
@export var tick_interval: float


func execute(entity: Entity) -> void:
	if condition:
		if !condition.execute(entity):
			return
	
	if action_on_start:
		action_on_start.execute(entity)
	
	var tick_timer = Timer.new()
	tick_timer.timeout.connect(
		func():
			if action_on_tick:
				action_on_tick.execute(entity)
			tick_timer.start(tick_interval)
	)
	entity.add_child(tick_timer)
	tick_timer.start(tick_interval)
	
	var cooldown_timer = Timer.new()
	cooldown_timer.timeout.connect(
		func():
			if action_on_end:
				action_on_end.execute(entity)
			entity.remove_child(cooldown_timer)
			entity.remove_child(tick_timer)
	)
	entity.add_child(cooldown_timer)
	cooldown_timer.start(duration)
