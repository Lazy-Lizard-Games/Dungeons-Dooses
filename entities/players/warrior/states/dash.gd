extends State

@export
var color_rect: ColorRect

@export
var idle_state: State

@export
var move_state: State

@export
var velocity_component: VelocityComponent

@export
var ability_component: AbilityComponent

@export
var state_component: StateComponent

var direction := Vector2.ZERO
var ability: Ability


func enter() -> void:
	color_rect.color = Color.YELLOW
	ability = ability_component.start(4, direction)
	ability.expired.connect(on_expired)
	ability.update_velocity.connect(on_update_velocity)


func exit() -> void:
	ability.expired.disconnect(on_expired)
	ability.update_velocity.disconnect(on_update_velocity)
	color_rect.color = Color.WHITE


func process_physics(delta: float) -> State:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction:
		var angle = velocity_component.velocity.angle_to(direction) * ability.control
		velocity_component.velocity = velocity_component.velocity.rotated(angle)
		# ability.direction = ability.direction.rotated(angle)
	return null


func on_expired() -> void:
	if direction.length() > 0:
		state_component.change_state(move_state)
		return
	state_component.change_state(idle_state)
	return


func on_update_velocity(velocity: Vector2, weight: float) -> void:
	velocity_component.accelerate_to_velocity(velocity, weight)
	velocity_component.move(parent)


