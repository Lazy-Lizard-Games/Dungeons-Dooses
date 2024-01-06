extends State

@export var color_rect: ColorRect
@export var move_state: State
@export var velocity_component: VelocityComponent
@export var ability_component: AbilityComponent
@export var hud_component: HudComponent

var interactable: InteractableComponent


func enter() -> void:
	color_rect.color = Color.AQUAMARINE


func exit() -> void:
	color_rect.color = Color.WHITE


func process_physics(_delta: float) -> State:
	if Input.get_vector("move_left", "move_right", "move_up", "move_down").length() > 0 and hud_component.visible:
		return move_state
	velocity_component.decelerate()
	velocity_component.move(parent)
	return null


func process_input(_event: InputEvent) -> State:
	return null

