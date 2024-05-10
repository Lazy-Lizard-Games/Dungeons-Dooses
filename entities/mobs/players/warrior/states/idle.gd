extends State

signal ability_pressed(type: Enums.AbilityType)

@export var player: Player
@export var walk_state: State
@export var velocity_component: VelocityComponent
@export var animation_tree: AnimationTree

func enter() -> void:
	animation_tree['parameters/playback'].start('idle')

func exit() -> void:
	pass

func process_physics(_delta: float) -> State:
	if Input.get_vector("move_left", "move_right", "move_up", "move_down").length() > 0:
		return walk_state
	velocity_component.decelerate()
	velocity_component.move(player)
	if Input.is_action_pressed("ability_1"):
		ability_pressed.emit(Enums.AbilityType.Primary)
	elif Input.is_action_pressed("ability_2"):
		ability_pressed.emit(Enums.AbilityType.Secondary)
	elif Input.is_action_pressed("ability_3"):
		ability_pressed.emit(Enums.AbilityType.Support)
	return null

func process_input(_event: InputEvent) -> State:
	return null
