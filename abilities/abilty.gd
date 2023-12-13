extends Node2D
class_name Ability

signal expired
signal update_velocity(velocity: Vector2, weight: float)
signal update_animation(animation: Animation)
signal update_control(control: float)
signal update_color(color: Color)


enum state {
	ACTIVE,
	COOLDOWN,
	READY
}

@export var cooldown: float

var current_state := state.READY
var faction: Globals.FACTION
var hurtbox_component: HurtboxComponent
var direction: Vector2

var cooldown_timer: Timer


func expire() -> void:
	if cooldown > 0:
		current_state = state.COOLDOWN
		cooldown_timer = Timer.new()
		add_child(cooldown_timer)
		cooldown_timer.timeout.connect(on_cooldown_timeout)
		cooldown_timer.start(cooldown)
	else:
		current_state = state.READY
	expired.emit()


func init(_faction: Globals.FACTION, _direction: Vector2, _hurtbox_component: HurtboxComponent) -> void:
	faction = _faction
	direction = _direction
	hurtbox_component = _hurtbox_component


## Signals that the ability should start doing things.
func start() -> void:
	pass


## Signals that the ability should release the charging ability or stop.
func release() -> void:
	pass


## Signals the end of the ability and that it should probably go home.
func cancel() -> void:
	pass


func on_cooldown_timeout() -> void:
	current_state = state.READY
	cooldown_timer.queue_free()
	cooldown_timer = null
