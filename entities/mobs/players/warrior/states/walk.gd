extends State

@export var player: Player
@export var idle_state: State

var direction := Vector2.ZERO

func enter() -> void:
	player.animation_player.play("walk_right")

func exit() -> void:
	pass

func process_frame(_delta: float) -> State:
	if Input.is_action_pressed("ability_1"):
		player.ability_component.start_ability(0)
	elif Input.is_action_pressed("ability_2"):
		player.ability_component.start_ability(1)
	elif Input.is_action_pressed("ability_3"):
		player.ability_component.start_ability(2)
	return null

func process_physics(_delta: float) -> State:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction.length() == 0:
		return idle_state
	player.velocity_component.accelerate_in_direction(direction)
	player.velocity_component.move(player)
	var current_position = player.animation_player.current_animation_position
	if abs(direction.x) >= abs(direction.y):
		if direction.x < 0:
			player.animation_player.play("walk_left")
		else:
			player.animation_player.play("walk_right")
	else:
		if direction.y < 0:
			player.animation_player.play("walk_up")
		else:
			player.animation_player.play("walk_down")
	player.animation_player.seek(current_position)

	return null
