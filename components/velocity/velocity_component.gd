extends Node
class_name VelocityComponent

## References the stats of the entity and is used more any movement values.
@export
var stats: StatsComponent
## How quickly the current velocity will reach the target velocity.
@export
var acceleration := 50.0:
	get:
		if stats:
			return stats.acceleration
		return acceleration
## The maximum speed that the entity can reach.
@export
var max_speed := 500.0:
	get:
		if stats:
			return stats.max_speed
		return max_speed
## How much knockback effects are reduced.
@export_range(0, 1)
var knockback_resist := 0.5:
	get:
		if stats:
			return stats.knockback_resist
		return knockback_resist

var velocity := Vector2(0.0, 0.0)


## Sets the current velocity to provided velocity. This method
## is designed to be used by knockback mechanics.
func set_velocity(_velocity: Vector2) -> void:
	velocity = _velocity


## Updates the the current velotiy by the provided velocity. 
## This method is designed to be used by 
func accelerate_to_velocity(_velocity: Vector2, _max_speed := max_speed, _acceleration := acceleration) -> void:
	velocity = velocity.lerp(_velocity, _acceleration / _max_speed)


## Moves the velocity towards the provided direction.
func accelerate_in_direction(direction: Vector2) -> void:
	accelerate_to_velocity(direction * max_speed)


func decelerate(friction: float) -> void:
	velocity = velocity.lerp(Vector2.ZERO, friction)


## Used to handle any recieved knockback.
## [br]
## TODO: implement duration and movement restrictions to knockback.
func handle_knockback(knockback: KnockbackData) -> void:
	if stats and stats.ignore_knockback:
		return
	knockback.force *= 1-knockback_resist
	set_velocity(knockback.direction * knockback.force)


## Updates the body's position by the velocity
func move(body: CharacterBody2D) -> void:
	body.velocity = self.velocity
	body.move_and_slide()
