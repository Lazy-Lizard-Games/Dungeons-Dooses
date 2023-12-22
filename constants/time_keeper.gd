extends Node


func create_timer(wait_time: float) -> Timer:
	var timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(func(): remove_child(timer))
	timer.start(wait_time)
	return timer
