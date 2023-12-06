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

var dash_timer: Timer

var one_timer := true


func _ready():
	dash_timer = Timer.new()
	dash_timer.one_shot = true
	dash_timer.timeout.connect(on_timeout)
	add_child(dash_timer)


## Signals that the ability should start doing things.
func start() -> void:
	update_control.emit(0.1)
	one_timer = true
	dash_timer.start(duration)
	current_state = state.ACTIVE


func _physics_process(delta: float) -> void:
	if current_state != state.ACTIVE:
		return
	
	if one_timer:
		update_velocity.emit(direction * max_speed, acceleration/ max_speed)
		one_timer = false
	if dash_timer.is_stopped():
		return
	
	update_velocity.emit(Vector2.ZERO, 0.05)


func on_timeout() -> void:
	update_control.emit(1)
	current_state = state.READY
	expire()
