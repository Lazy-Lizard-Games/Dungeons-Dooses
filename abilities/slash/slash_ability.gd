extends Ability

func start() -> void:
	var timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(stop)
	timer.start(1)
	if weapon.stats:
		weapon.stats.ignore_knockback = true


func stop() -> void:
	if weapon.stats:
		weapon.stats.ignore_knockback = false
	expired.emit()

var speed = 500
func _process(delta: float) -> void:
	if weapon:
		weapon.accelerate_player.emit(direction * speed, speed, 250)
