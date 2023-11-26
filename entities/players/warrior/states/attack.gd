extends State

@export
var color_rect: ColorRect

@export
var idle_state: State

@export
var move_state: State

@export
var dash_state: State

@export
var velocity_component: VelocityComponent

@export
var stats_component: StatsComponent

@export
var weapon_component: WeaponComponent

var direction := Vector2.ZERO
var ability_expired := false


func enter() -> void:
	ability_expired = false
	color_rect.color = Color.INDIAN_RED
	weapon_component.ability_expired.connect(func(): ability_expired = true)
	weapon_component.start(parent.selected_ability, parent.global_position.direction_to(parent.get_global_mouse_position()))


func exit() -> void:
	color_rect.color = Color.WHITE


func process_frame(delta: float) -> State:
	if ability_expired:
		if direction.length() > 0:
			return move_state
		return idle_state
	return null


func process_physics(delta: float) -> State:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if stats_component:
		direction *= stats_component.control
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(parent)
	return null


func process_input(event: InputEvent) -> State:
	if Input.is_action_just_released("primary"):
		weapon_component.release(parent.selected_ability)
	
	if Input.is_action_just_pressed("secondary"):
		weapon_component.cancel()
	
	if Input.is_action_just_pressed("dash"):
		weapon_component.cancel()
		dash_state.direction = direction
		return dash_state
	
	return null
