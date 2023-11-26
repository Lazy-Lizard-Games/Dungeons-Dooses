extends State

@export
var color_rect: ColorRect

@export
var move_state: State

@export
var velocity_component: VelocityComponent

@export
var stats_component: StatsComponent


func enter() -> void:
	color_rect.color = Color.AQUAMARINE


func exit() -> void:
	color_rect.color = Color.WHITE


func process_physics(delta: float) -> State:
	velocity_component.decelerate(stats_component.friction)
	velocity_component.move(parent)
	return null


func process_input(event: InputEvent) -> State:
	if Input.get_vector("move_left", "move_right", "move_up", "move_down").length() > 0:
		return move_state
	return null
