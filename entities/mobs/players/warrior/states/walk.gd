extends State

signal ability_pressed(type: Enums.AbilityType)

@export var player: Player
@export var idle_state: State
@export var velocity_component: VelocityComponent
@export var animation_player: AnimationPlayer

var direction := Vector2.ZERO

func enter() -> void:
	animation_player.play("walk_right")

func exit() -> void:
	pass

func process_frame(_delta: float) -> State:
	if Input.is_action_pressed("ability_1"):
		ability_pressed.emit(Enums.AbilityType.Primary)
	elif Input.is_action_pressed("ability_2"):
		ability_pressed.emit(Enums.AbilityType.Secondary)
	elif Input.is_action_pressed("ability_3"):
		ability_pressed.emit(Enums.AbilityType.Support)
	return null

func process_physics(_delta: float) -> State:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction.length() == 0:
		return idle_state
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(player)
	
	var current_position = animation_player.current_animation_position
	if abs(direction.x) >= abs(direction.y):
		if direction.x < 0:
			animation_player.play("walk_left")
		else:
			animation_player.play("walk_right")
	else:
		if direction.y < 0:
			animation_player.play("walk_up")
		else:
			animation_player.play("walk_down")
	animation_player.seek(current_position)

	return null
