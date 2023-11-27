extends Ability

## How long the dash will last for. 
@export
var duration := 0.1
## How fast the entity can move while dashing.
@export
var max_speed := 2500
## How fast the entity will reach max speed while dashing.
@export
var acceleration := 1250

var timer: Timer

## Signals that the ability should start doing things.
func start() -> void:
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(on_timeout)
	timer.start(duration)


func _physics_process(delta: float) -> void:
	if timer.is_stopped():
		return
	update_velocity.emit(direction * max_speed, max_speed, acceleration)


func on_timeout() -> void:
	if weapon and weapon.stats:
		weapon.stats.control = 1
	expire()
