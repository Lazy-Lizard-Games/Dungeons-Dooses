extends State

@export
var color_rect: ColorRect

@export
var idle_state: State

@export
var velocity_component: VelocityComponent

@export
var stats_component: StatsComponent


func enter() -> void:
	color_rect.color = Color.AQUA


func exit() -> void:
	color_rect.color = Color.WHITE


func process_physics(delta) -> State:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction.length() == 0:
		return idle_state
	if stats_component:
		direction *= stats_component.control
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(parent)
	return null
