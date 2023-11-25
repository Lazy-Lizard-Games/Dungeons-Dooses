extends Node
class_name VelocityComponent

@export var acceleration := 50.0
@export var max_speed := 500.0

var velocity := Vector2(0.0, 0.0)


## Sets the current velocity to provided velocity. This method
## is designed to be used by knockback mechanics.
func set_velocity(_velocity: Vector2) -> void:
	velocity = _velocity


## Updates the the current velotiy by the provided velocity. 
## This method is designed to be used by 
func accelerate_to_velocity(_velocity: Vector2, _speed := max_speed, _acceleration := acceleration) -> void:
	velocity = velocity.lerp(_velocity, _acceleration / _speed)


## Updates the body's position by the velocity
func move(body: CharacterBody2D) -> void:
	body.velocity = self.velocity
	body.move_and_slide()
