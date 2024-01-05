extends Node
class_name VelocityComponent

## Max speed if attributes not attached or no speed attribute found.
@export var speed = Attribute.new()
## How much impact entity input has on the velocity
@export var control= Attribute.new()
## How much impact any input has on the velocity
@export var friction= Attribute.new()
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


## Sets the current velocity to provided velocity. This method
## is designed to be used by knockback mechanics.
func set_velocity(_velocity: Vector2) -> void:
	velocity = _velocity


func add_velocity(_velocity: Vector2) -> void:
	velocity += _velocity


## Updates the the current velotiy by the provided velocity. 
## This method is designed to be used by 
func accelerate_to_velocity(_velocity: Vector2, weight: float ) -> void:
	velocity = velocity.lerp(_velocity, weight)


## Accelerates the velocity towards the provided direction.
func accelerate_in_direction(
	direction: Vector2
) -> void:
	accelerate_to_velocity(direction * speed.get_final_value(), friction.get_final_value() * control.get_final_value())


## Decelerates the velocity towards zero.
func decelerate() -> void:
	accelerate_in_direction(Vector2.ZERO)


## Updates the body's position by the velocity
func move(body: CharacterBody2D) -> void:
	body.velocity = self.velocity
	body.move_and_slide()
