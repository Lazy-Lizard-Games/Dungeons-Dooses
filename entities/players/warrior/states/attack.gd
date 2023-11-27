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
var ability_component: AbilityComponent

@export
var state_component: StateComponent

var direction := Vector2.ZERO
var ability: Ability

func enter() -> void:
	color_rect.color = Color.INDIAN_RED
	ability = ability_component.start(parent.selected_ability, parent.global_position.direction_to(parent.get_global_mouse_position()))
	ability.expired.connect(on_expired)


func exit() -> void:
	color_rect.color = Color.WHITE


func process_physics(delta: float) -> State:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if stats_component:
		direction *= stats_component.control
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(parent)
	return null


func process_input(event: InputEvent) -> State:
	if Input.is_action_just_released("primary"):
		ability_component.release(parent.selected_ability)
	
	if Input.is_action_just_pressed("secondary"):
		ability_component.cancel()
	
	if Input.is_action_just_pressed("dash"):
		ability_component.cancel()
		dash_state.direction = direction
		return dash_state
	
	return null


func on_expired() -> void:
	if direction.length() > 0:
		state_component.change_state(move_state)
		return
	state_component.change_state(idle_state)
	return
