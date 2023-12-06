extends Ability

## How long the dash will last for. 
@export
var duration := 0.1
## How fast the entity can move while dashing.
@export
var max_speed := 2500.0
## How fast the entity will reach max speed while dashing.
@export
var acceleration := 1250.0

var timer: Timer

var one_timer := true

## Signals that the ability should start doing things.
func start() -> void:
	one_timer = true
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(on_timeout)
	timer.start(duration)
	current_state = state.ACTIVE


func _physics_process(delta: float) -> void:
	if current_state != state.ACTIVE:
		return
	
	if one_timer:
		update_velocity.emit(direction * max_speed, acceleration/ max_speed)
		one_timer = false
	if timer.is_stopped():
		return
	
	update_velocity.emit(Vector2.ZERO, 0.05)


func on_timeout() -> void:
	ability_component.stats.control = 1
	current_state = state.READY
	timer.queue_free()
	expire()
