extends State

@export var color_rect: ColorRect
@export var idle_state: State
@export var attack_state: State
@export var dash_state: State
@export var velocity_component: VelocityComponent

var direction := Vector2.ZERO


func enter() -> void:
	color_rect.color = Color.AQUA


func exit() -> void:
	color_rect.color = Color.WHITE


func process_physics(delta: float) -> State:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction.length() == 0:
		return idle_state
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(parent)
	return null


func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("primary"):
		return attack_state
	
	if Input.is_action_just_pressed("dash"):
		dash_state.direction = direction
		return dash_state
	
	return null
