extends BientityAction
class_name CooldownBientity

## Triggers an action over time on the pair.

## Action to trigger when cooldown starts.
@export var action_on_start: BientityAction
## Action to trigger on every tick interval.
@export var action_on_tick: BientityAction
## Action to trigger when cooldown ends.
@export var action_on_end: BientityAction
## Duration of cooldown in seconds.
@export var duration: float
## Tick interval in seconds.
@export var tick_interval: float


func execute(actor: Entity, target: Entity, scale := 1.0) -> void:
	if duration <= 0:
		return
	
	if condition:
		if !condition.execute(actor, target):
			return
	
	if action_on_start:
		action_on_start.execute(actor, target, scale)
	
	var tick_timer = Timer.new()
	tick_timer.timeout.connect(
		func():
			if action_on_tick:
				action_on_tick.execute(actor, target, scale)
			tick_timer.start(tick_interval)
	)
	target.add_child(tick_timer)
	tick_timer.start(tick_interval)
	
	var cooldown_timer = Timer.new()
	cooldown_timer.timeout.connect(
		func():
			if action_on_end:
				action_on_end.execute(actor, target, scale)
			target.remove_child(cooldown_timer)
			target.remove_child(tick_timer)
	)
	target.add_child(cooldown_timer)
	cooldown_timer.start(duration)
