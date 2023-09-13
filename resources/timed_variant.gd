extends Node
class_name TimedVariant

signal timeout(variant: Variant)

@onready var root = get_tree().root

var variant: Variant
var timer: Timer


func start(time: float) -> void:
	if time > 0:
		timer = Timer.new()
		root.add_child(timer)
		timer.wait_time = time
		timer.connect("timeout", on_timer_timeout)
		timer.one_shot = true
		timer.start()

func on_timer_timeout() -> void:
	root.remove_child(timer)
	timeout.emit(self)
