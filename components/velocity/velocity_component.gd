extends Node
class_name VelocityComponent


@export var stats: StatsComponent
@export var max_speed: float = 100
@export var acceleration: float = 20

var calculated_max_speed : float :
	get:
		return max_speed * stats.move_speed_mult if stats else max_speed
var calculated_acceleration: float :
	get:
		return acceleration * stats.accelerate_mult if stats else acceleration
var velocity: Vector2 = Vector2.ZERO

func accelerate_to_velocity(_velocity: Vector2) -> void:
	velocity = velocity.lerp(_velocity, calculated_acceleration / calculated_max_speed)

func accelerate_in_direction(direction: Vector2) -> void:
	accelerate_to_velocity(direction * calculated_max_speed)

func decelerate() -> void:
	accelerate_in_direction(Vector2.ZERO)

func move(character_body: CharacterBody2D) -> void:
	character_body.velocity = velocity
	character_body.move_and_slide()
