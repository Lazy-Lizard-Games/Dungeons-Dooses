extends State

@export var mob: Mob
@export var velocity_component: VelocityComponent

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_physics(_delta: float) -> State:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity_component.accelerate_in_direction(direction)
	# velocity_component.move(mob)
	return null

func process_input(_event: InputEvent) -> State:
	return null
