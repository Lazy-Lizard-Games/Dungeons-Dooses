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
	ability = ability_component.get_ability(parent.selected_ability)
	if !ability or ability.is_recharging:
		switch_state()
		return
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction.length() == 0:
		direction = parent.global_position.direction_to(parent.get_global_mouse_position())
	color_rect.color = Color.INDIAN_RED
	ability.casted.connect(
		func():
			switch_state()
	)
	ability.cast(parent, direction)


func exit() -> void:
	color_rect.color = Color.WHITE
	if !ability:
		return


func process_physics(_delta: float) -> State:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(parent)
	return null


func switch_state() -> void:
	if direction.length() > 0:
		state_component.change_state(move_state)
		return
	state_component.change_state(idle_state)


func on_expired() -> void:
	switch_state()
