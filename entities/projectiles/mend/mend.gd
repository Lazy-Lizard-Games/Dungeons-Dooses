extends Projectile

## Projectile for the mend ability of the warrior.

func _ready():
	get_tree().create_timer(0.5).timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	ProjectileHandler.remove_projectile(self)