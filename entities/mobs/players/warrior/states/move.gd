extends State

@export var color_rect: ColorRect
@export var idle_state: State
@export var attack_state: State
@export var velocity_component: VelocityComponent
@export var ability_component: AbilityComponent

var direction := Vector2.ZERO


func enter() -> void:
	color_rect.color = Color.AQUA


func exit() -> void:
	color_rect.color = Color.WHITE


func process_physics(_delta: float) -> State:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction.length() == 0:
		return idle_state
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(parent)
	if Input.is_action_pressed("primary"):
		var ability = ability_component.get_ability(parent.selected_ability)
		if !ability and ability.is_recharging:
			return null
		return attack_state
	return null
