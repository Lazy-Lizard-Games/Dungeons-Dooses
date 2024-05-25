extends Node
class_name VelocityComponent

signal knockback_recieved(strength: float)

## A stats component can be adde to transform values before being used.
@export var stats_component: StatsComponent
## Max speed if attributes not attached or no speed attribute found.
@export var speed: float:
	get:
		if stats_component:
			return speed * stats_component.movement_speed.get_final_value()
		return speed
## How much impact entity input has on the velocity
@export var acceleration: float:
	get:
		if stats_component:
			return acceleration * stats_component.movement_acceleration.get_final_value()
		return acceleration
## How much impact any input has on the velocity
@export_range(0, 1) var friction: float:
	get:
		if stats_component:
			return friction * stats_component.movement_friction.get_final_value()
		return friction
var velocity := Vector2.ZERO
var knockback_control = 1

## Sets the current velocity to provided velocity. This method
## is designed to be used by knockback mechanics.
func set_velocity(_velocity: Vector2) -> void:
	velocity = _velocity

func add_velocity(_velocity: Vector2) -> void:
	velocity += _velocity

## Updates the the current velotiy by the provided velocity. 
## This method is designed to be used by 
func accelerate_to_velocity(velocity_to: Vector2) -> void:
	velocity = velocity.lerp(velocity_to, (acceleration / speed) * friction * knockback_control)

## Accelerates the velocity towards the provided direction.
func accelerate_in_direction(direction: Vector2) -> void:
	accelerate_to_velocity(direction * speed)

## Decelerates the velocity towards zero.
func decelerate() -> void:
	accelerate_in_direction(Vector2.ZERO)

## Updates the body's position by the velocity
func move(body: CharacterBody2D) -> void:
	body.velocity = self.velocity
	body.move_and_slide()

func knockback(strength: float, direction: Vector2) -> void:
	add_velocity(direction * strength)
	knockback_control = 0
	knockback_recieved.emit(strength)

func apply_resistance(strength: float) -> float:
	return strength * stats_component.knockback_resistance.get_final_value()

func knockback_with_transforms(strength: float, direction: Vector2) -> void:
	return knockback(apply_resistance(strength), direction)

func _process(delta):
	if knockback_control < 1:
		knockback_control = min(knockback_control + delta, 1)