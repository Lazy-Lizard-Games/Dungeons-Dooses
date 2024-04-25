extends State

signal ability_pressed(index: int)

@export var move_state: State
@export var velocity_component: VelocityComponent
@export var ability_component: AbilityComponent
@export var animation_tree: AnimationTree

var interactable: InteractableComponent

func enter() -> void:
	entity.can_attack = true
	animation_tree['parameters/playback'].travel('idle')

func exit() -> void:
	pass

func process_physics(_delta: float) -> State:
	if Input.is_action_pressed("ability_1"):
		ability_pressed.emit(0)

	if Input.is_action_pressed("ability_2"):
		ability_pressed.emit(1)

	if Input.is_action_pressed("ability_3"):
		ability_pressed.emit(2)

	if Input.is_action_pressed("ability_4"):
		ability_pressed.emit(3)

	if Input.get_vector("move_left", "move_right", "move_up", "move_down").length() > 0:
		return move_state
	velocity_component.decelerate()
	velocity_component.move(entity)
	return null

func process_input(_event: InputEvent) -> State:
	return null
