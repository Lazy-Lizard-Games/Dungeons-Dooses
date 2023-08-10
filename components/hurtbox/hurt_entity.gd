extends Resource
class_name HurtEntity

signal timeout(hurt_entity: HurtEntity)

var area: Area2D
var timer: Timer

func set_data(entity: Area2D, rate: float) -> void:
	area = entity
	if rate > 0:
		timer = Timer.new()
		area.add_child(timer)
		timer.wait_time = 1.0/rate
		timer.connect("timeout", _timer_timeout)
		timer.one_shot = true
		timer.start()

func get_area() -> Area2D:
	return area

func _timer_timeout() -> void:
	area.remove_child(timer)
	timeout.emit(self)
