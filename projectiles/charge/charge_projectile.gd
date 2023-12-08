extends Projectile

var timer: Timer


func enter() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(func(): expired.emit(self) )
	timer.start(1)

