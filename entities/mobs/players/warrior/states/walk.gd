extends State

signal ability_pressed(index: int)

@export var player: Player
@export var idle_state: State
@export var velocity_component: VelocityComponent
@export var animation_tree: AnimationTree

var direction := Vector2.ZERO

func enter() -> void:
	animation_tree['parameters/playback'].start('walk')

func exit() -> void:
	pass

func process_physics(_delta: float) -> State:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction.length() == 0:
		return idle_state
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(player)
	animation_tree['parameters/walk/blend_position'] = direction.normalized()
	if Input.is_action_pressed("ability_1"):
		ability_pressed.emit(0)
	elif Input.is_action_pressed("ability_2"):
		ability_pressed.emit(1)
	elif Input.is_action_pressed("ability_3"):
		ability_pressed.emit(2)
	elif Input.is_action_pressed("ability_4"):
		ability_pressed.emit(3)
	return null
