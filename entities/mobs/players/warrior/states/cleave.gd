extends State

@export var idle_state: State
@export var animation_tree: AnimationTree
var ability: Ability
var is_finished = false

func enter() -> void:
	ability.start(entity)
	animation_tree['parameters/playback'].travel('cleave')
	animation_tree['parameters/cleave/blend_position'] = entity.looking_at
	animation_tree.animation_finished.connect(on_animation_finished, CONNECT_ONE_SHOT)

func on_animation_finished(_animation) -> void:
	is_finished = true

func exit() -> void:
	is_finished = false
	ability.end(entity)
	return

func process_physics(_delta: float) -> State:
	if is_finished:
		return idle_state
	return null
