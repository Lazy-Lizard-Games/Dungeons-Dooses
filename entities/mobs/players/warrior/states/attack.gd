extends State

@export var color_rect: ColorRect
@export var idle_state: State
@export var move_state: State
@export var velocity_component: VelocityComponent
@export var ability_component: AbilityComponent
@export var state_component: StateComponent

var direction := Vector2.ZERO
var ability: Ability


func enter() -> void:
	ability = ability_component.get_ability(entity.selected_ability)
	if !ability or !ability.can_start(entity):
		switch_state()
		return
	color_rect.color = Color.INDIAN_RED
	ability.finished.connect(
		func():
			switch_state()
	)
	ability.start(entity)
	entity.render_component.play(ability.animation_on_start + '_sideways')


func exit() -> void:
	color_rect.color = Color.WHITE
	if !ability:
		return


func process_physics(_delta: float) -> State:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(entity)
	
	var direction = entity.looking_at
	var angle = direction.angle()
	var current_frame = entity.render_component.get_frame()
	var current_progress = entity.render_component.get_frame_progress()
	entity.render_component.flip_h = false
	if angle < Vector2(1, -1).angle() && angle > Vector2(-1, -1).angle():
		entity.render_component.play(ability.animation_on_start + '_up')
	elif angle > Vector2(1, 1).angle() && angle < Vector2(-1, 1).angle():
		entity.render_component.play(ability.animation_on_start + '_down')
	else:
		entity.render_component.play(ability.animation_on_start + '_sideways')
		entity.render_component.flip_h = direction.x < 0
	entity.render_component.set_frame_and_progress(current_frame, current_progress)
	
	return null


func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_released("primary"):
		ability.release(entity)
		return null
	if Input.is_action_just_pressed("secondary"):
		ability.cancel(entity)
		return idle_state
	return null


func switch_state() -> void:
	if direction.length() > 0:
		state_component.change_state(move_state)
		return
	state_component.change_state(idle_state)


func on_expired() -> void:
	switch_state()
