extends Node
class_name Ability

signal expired
signal update_velocity(velocity: Vector2, weight: float)
signal update_animation(animation: Animation)
signal update_color(color: Color)

@export_range(0, 1)
var control: float

var activated := false
var ability: AbilityComponent
var direction: Vector2


## Initialises required data before activating the ability. 
func init(_ability: AbilityComponent, _direction: Vector2) -> void:
	ability = _ability
	direction = _direction


func expire() -> void:
	expired.emit()


## Signals that the ability should start doing things.
func start() -> void:
	pass


## Signals that the ability should release the charging ability or stop.
func release() -> void:
	pass


## Signals the end of the ability and that it should probably go home.
func cancel() -> void:
	pass
