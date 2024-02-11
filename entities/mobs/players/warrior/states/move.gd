extends State

@export var color_rect: ColorRect
@export var idle_state: State
@export var velocity_component: VelocityComponent
@export var ability_component: AbilityComponent

var direction := Vector2.ZERO


func enter() -> void:
	
	color_rect.color = Color.AQUA


func exit() -> void:
	color_rect.color = Color.WHITE


func process_input(_event: InputEvent) -> State:
	return null


func process_physics(_delta: float) -> State:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction.length() == 0:
		return idle_state
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(entity)
	
	var angle = direction.angle()
	var current_frame = entity.render_component.get_frame()
	var current_progress = entity.render_component.get_frame_progress()
	entity.render_component.flip_h = false
	if angle <= Vector2(1, -1).angle() && angle >= Vector2(-1, -1).angle():
		entity.render_component.play('walk_up')
	elif angle >= Vector2(1, 1).angle() && angle <= Vector2(-1, 1).angle():
		entity.render_component.play('walk_down')
	else:
		entity.render_component.play('walk_sideways')
		entity.render_component.flip_h = direction.x < 0
	entity.render_component.set_frame_and_progress(current_frame, current_progress)
	return null
