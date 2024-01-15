extends Projectile


func _process(_delta: float) -> void:
	if direction.length() > 0:
		velocity_component.accelerate_in_direction(direction)
		velocity_component.move(self)
