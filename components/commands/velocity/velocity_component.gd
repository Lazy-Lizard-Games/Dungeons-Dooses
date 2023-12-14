extends Node
class_name VelocityComponent

## How quickly the current velocity will reach the target velocity.
@export var acceleration: Attribute

## The maximum speed that the entity can reach.
@export var max_speed: Attribute

## How much knockback effects are reduced.
@export var knockback_resist: Attribute

## How much impact entity input has on the velocity
@export_range(0, 1) var control: float = 1

## How much impact any input has on the velocity
@export_range(0, 1) var friction: float = 1

var velocity := Vector2(0.0, 0.0)


## Sets the current velocity to provided velocity. This method
## is designed to be used by knockback mechanics.
func set_velocity(_velocity: Vector2) -> void:
	velocity = _velocity


## Updates the the current velotiy by the provided velocity. 
## This method is designed to be used by 
func accelerate_to_velocity(_velocity: Vector2, weight: float ) -> void:
	velocity = velocity.lerp(_velocity, weight)


## Moves the velocity towards the provided direction.
func accelerate_in_direction(direction: Vector2, _max_speed := max_speed.get_final_value(), _acceleration := acceleration.get_final_value()) -> void:
	accelerate_to_velocity(direction * _max_speed, _acceleration / _max_speed)


func decelerate() -> void:
	velocity = velocity.lerp(Vector2.ZERO, friction)


## Used to handle any recieved knockback.
## TODO: implement duration and movement restrictions to knockback.
func handle_knockback(knockback: KnockbackData, origin: Vector2) -> void:
	knockback.force *= 1-(knockback_resist.get_final_value())
	set_velocity(knockback.direction * knockback.force)


## Updates the body's position by the velocity
func move(body: CharacterBody2D) -> void:
	body.velocity = self.velocity
	body.move_and_slide()
