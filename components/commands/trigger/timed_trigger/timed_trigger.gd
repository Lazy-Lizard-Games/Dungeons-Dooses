extends TriggerComponent
class_name TimedTriggerComponent

## Triggers at regular intervals.

## Time in seconds between triggers.
@export var interval: Number


func _ready():
	var trigger_timer = Timer.new()
	trigger_timer.timeout.connect(
		func():
			triggered.emit()
			trigger_timer.start(interval.execute())
	)
	add_child(trigger_timer)
	trigger_timer.start(interval.execute())
