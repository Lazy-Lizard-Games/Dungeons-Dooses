extends State

@export var idle_state: State
@export var animation_tree: AnimationTree
var ability: Ability
var is_finished = false

func enter() -> void:
	ability.start(entity)
	animation_tree['parameters/playback'].travel('smite')
	animation_tree['parameters/smite/blend_position'] = entity.looking_at
	animation_tree.animation_finished.connect(on_animation_finished, CONNECT_ONE_SHOT)


func on_animation_finished(animation) -> void:
	is_finished = true


func exit() -> void:
	is_finished = false
	ability.end(entity)
	return


func process_physics(_delta: float) -> State:
	if is_finished:
		return idle_state
	return null


func process_input(_event: InputEvent) -> State:
	return null
