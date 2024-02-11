extends State

@export var color_rect: ColorRect
@export var move_state: State
@export var velocity_component: VelocityComponent
@export var ability_component: AbilityComponent

var interactable: InteractableComponent


func enter() -> void:
	entity.render_component.update_animation('idle')
	color_rect.color = Color.AQUAMARINE


func exit() -> void:
	color_rect.color = Color.WHITE


func process_physics(_delta: float) -> State:
	if Input.get_vector("move_left", "move_right", "move_up", "move_down").length() > 0:
		return move_state
	velocity_component.decelerate()
	velocity_component.move(entity)
	return null


func process_input(_event: InputEvent) -> State:
	return null

