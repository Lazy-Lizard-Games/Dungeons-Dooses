extends Projectile

## A hit-scan projectile that searches for targets in a straight line.

func _ready():
	get_tree().create_timer(0.1).timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	ProjectileHandler.remove_projectile(self)