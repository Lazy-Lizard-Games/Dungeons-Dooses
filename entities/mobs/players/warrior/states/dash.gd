extends State

@export var color_rect: ColorRect
@export var idle_state: State
@export var move_state: State
@export var velocity_component: VelocityComponent
@export var ability_component: AbilityComponent
@export var state_component: StateComponent
@export var hurtbox_component: HurtboxComponent

var direction := Vector2.ZERO
var ability: Ability


func enter() -> void:
	color_rect.color = Color.YELLOW
	ability = ability_component.get_ability(4)
	if !ability:
		switch_state()
		return
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction.length() == 0:
		direction = parent.global_position.direction_to(parent.get_global_mouse_position())
	ability.init(parent.faction, direction, hurtbox_component)
	ability.expired.connect(on_expired)
	ability.update_color.connect(on_update_color)
	ability.update_velocity.connect(on_update_velocity)
	ability.update_control.connect(on_update_control)
	ability.start()


func exit() -> void:
	color_rect.color = Color.WHITE
	if !ability:
		return
	ability.expired.disconnect(on_expired)
	ability.update_color.disconnect(on_update_color)
	ability.update_velocity.disconnect(on_update_velocity)
	ability.update_control.disconnect(on_update_control)


func process_physics(delta: float) -> State:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	#if direction:
	#	var angle = velocity_component.velocity.angle_to(direction) * velocity_component.control
	#	velocity_component.velocity = velocity_component.velocity.rotated(angle)
	velocity_component.move(parent)
	return null


func switch_state() -> void:
	if direction.length() > 0:
		state_component.change_state(move_state)
		return
	state_component.change_state(idle_state)


func on_expired() -> void:
	switch_state()


func on_update_velocity(velocity: Vector2, weight: float) -> void:
	velocity_component.accelerate_to_velocity(velocity, weight)


func on_update_color(color: Color) -> void:
	color_rect.color = color


func on_update_control(control: float) -> void:
	#velocity_component.control = control
	pass

