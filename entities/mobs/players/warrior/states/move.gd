extends State

@export var color_rect: ColorRect
@export var idle_state: State
@export var velocity_component: VelocityComponent
@export var ability_component: AbilityComponent
@export var hud_component: HudComponent

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
	if hud_component.visible:
		velocity_component.accelerate_in_direction(direction)
		velocity_component.move(entity)
	return null
