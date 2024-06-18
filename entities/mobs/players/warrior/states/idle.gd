extends State

@export var player: Player
@export var walk_state: State

func enter() -> void:
	player.animation_player.play("idle")

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
	if Input.get_vector("move_left", "move_right", "move_up", "move_down").length() > 0:
		return walk_state
	player.velocity_component.decelerate()
	player.velocity_component.move(player)
	return null
