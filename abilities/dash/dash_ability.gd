extends Ability

## How long the dash will last for. 
@export
var duration := 0.05
## How fast the entity can move while dashing.
@export
var max_speed := 7500
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
	if weapon and weapon.stats:
		weapon.stats.control = 0.2 


func _process(delta: float) -> void:
	if timer.is_stopped() or not weapon:
		return
	weapon.accelerate_entity.emit(direction * max_speed, max_speed, acceleration)
	# velocity: Vector2, max_speed: float, acceleration: float


func on_timeout() -> void:
	if weapon and weapon.stats:
		weapon.stats.control = 1
	expire()
