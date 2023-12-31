extends State

@export var color_rect: ColorRect
@export var move_state: State
@export var attack_state: State
@export var velocity_component: VelocityComponent

var interactable: InteractableComponent


func enter() -> void:
	color_rect.color = Color.AQUAMARINE


func exit() -> void:
	color_rect.color = Color.WHITE


func process_physics(delta: float) -> State:
	velocity_component.decelerate()
	velocity_component.move(parent)
	return null


func process_input(event: InputEvent) -> State:
	if Input.get_vector("move_left", "move_right", "move_up", "move_down").length() > 0:
		return move_state
	
	if Input.is_action_just_pressed("primary"):
		return attack_state

	return null

