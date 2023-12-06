extends Node
class_name Ability

signal expired
signal update_velocity(velocity: Vector2, weight: float)
signal update_animation(animation: Animation)
signal update_color(color: Color)

@export_range(0, 1)
var control: float

enum state {
	ACTIVE,
	COOLDOWN,
	READY
}

var current_state := state.READY
var ability_component: AbilityComponent
var direction: Vector2


## Initialises required data before activating the ability. 
func init(_ability_component: AbilityComponent, _direction: Vector2) -> void:
	ability_component = _ability_component
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
