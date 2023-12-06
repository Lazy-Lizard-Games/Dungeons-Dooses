extends Node
class_name Ability

signal expired
signal update_velocity(velocity: Vector2, weight: float)
signal update_animation(animation: Animation)
signal update_control(control: float)
signal update_color(color: Color)


enum state {
	ACTIVE,
	COOLDOWN,
	READY,
	EXPIRED
}

var current_state := state.READY
var hurtbox_component: HurtboxComponent
var direction: Vector2


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
