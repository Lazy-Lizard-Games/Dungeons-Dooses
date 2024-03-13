extends Node
class_name VelocityComponent

## Max speed if attributes not attached or no speed attribute found.
@export var speed = Attribute.new(25)
## How much impact entity input has on the velocity
@export var acceleration = Attribute.new(10)
## How much impact any input has on the velocity
@export var friction = Attribute.new(1)
var velocity := Vector2.ZERO
## Attribute Component to fetch speed, acceleration, etc. from.
var generics: GenericAttributes:
	set(g):
		generics = g
		if !generics:
			return
		var s = generics.get_generic(Enums.GenericType.MovementSpeed)
		if s:
			speed = s
		var a = generics.get_generic(Enums.GenericType.Acceleration)
		if a:
			acceleration = a
		var f = generics.get_generic(Enums.GenericType.Friction)
		if f:
			friction = f

## Sets the current velocity to provided velocity. This method
## is designed to be used by knockback mechanics.
func set_velocity(_velocity: Vector2) -> void:
	velocity = _velocity

func add_velocity(_velocity: Vector2) -> void:
	velocity += _velocity

## Updates the the current velotiy by the provided velocity. 
## This method is designed to be used by 
func accelerate_to_velocity(velocity_to: Vector2) -> void:
	velocity = velocity.lerp(velocity_to, (acceleration.get_final_value() / speed.get_final_value()) * friction.get_final_value())

## Accelerates the velocity towards the provided direction.
func accelerate_in_direction(direction: Vector2) -> void:
	accelerate_to_velocity(direction * speed.get_final_value())

## Decelerates the velocity towards zero.
func decelerate() -> void:
	accelerate_in_direction(Vector2.ZERO)

## Updates the body's position by the velocity
func move(body: CharacterBody2D) -> void:
	body.velocity = self.velocity
	body.move_and_slide()
