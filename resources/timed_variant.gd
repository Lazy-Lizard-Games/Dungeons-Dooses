extends Node
class_name TimedVariant

signal timeout(variant: Variant)

@onready var root = get_tree().root

var variant: Variant
var timer: Timer


func start(_variant: Variant, time: float) -> void:
	variant = _variant
	if time > 0:
		timer = Timer.new()
		root.add_child(timer)
		timer.wait_time = time
		timer.connect("timeout", _timer_timeout)
		timer.one_shot = true
		timer.start()

func _timer_timeout() -> void:
	root.remove_child(timer)
	timeout.emit(self)
