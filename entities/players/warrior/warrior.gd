extends Entity

@export var velocity_component: VelocityComponent


func _physics_process(delta):
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity_component.accelerate_to_velocity(direction * velocity_component.max_speed)
	velocity_component.move(self)
