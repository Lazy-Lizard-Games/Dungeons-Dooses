extends Projectile

@onready var timer: Timer = $Timer

func start() -> void:
	timer.start()

func _on_timer_timeout() -> void:
	queue_free()
