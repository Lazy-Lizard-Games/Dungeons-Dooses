class_name Warrior
extends Mob

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity_component.accelerate_in_direction(direction * delta)
	# velocity_component.move(self)