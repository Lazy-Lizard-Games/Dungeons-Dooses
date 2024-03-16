extends State

@export var idle_state: State
@export var animation_tree: AnimationTree
@export var velocity: VelocityComponent
var ability: Ability
var is_finished := false
var direction := Vector2.ZERO

func enter() -> void:
	ability.start(entity)
	animation_tree['parameters/playback'].travel('rally')
	animation_tree.animation_finished.connect(on_animation_finished, CONNECT_ONE_SHOT)

func on_animation_finished(_animation) -> void:
	is_finished = true

func exit() -> void:
	is_finished = false
	ability.end()
	return

func process_physics(_delta: float) -> State:
	if is_finished:
		return idle_state
	velocity.accelerate_in_direction(direction * 0.05)
	velocity.move(entity)
	return null
