extends State

@export var idle_state: State
@export var animation_tree: AnimationTree
var is_finished = false
var ability: Ability
var timer: Timer

## Start
func enter() -> void:
	ability.start(entity)
	animation_tree['parameters/playback'].travel('parry')
	animation_tree.animation_finished.connect(on_start_finished, CONNECT_ONE_SHOT)

func exit() -> void:
	timer = null
	is_finished = false
	ability.end()
	return

func process_physics(_delta: float) -> State:
	if is_finished:
		return idle_state
	return null

## Idle
func on_start_finished(_animation: String) -> void:
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.start(1)
	timer.timeout.connect(on_timeout, CONNECT_ONE_SHOT)
	entity.hit.connect(on_hit, CONNECT_ONE_SHOT)

## Attack
func on_hit(_entity: Entity) -> void:
	remove_child(timer)
	timer.timeout.disconnect(on_timeout)
	animation_tree['parameters/playback'].travel('parry/attack')
	animation_tree.animation_finished.connect(on_finished, CONNECT_ONE_SHOT)
	ability.cast()

## End
func on_timeout() -> void:
	remove_child(timer)
	entity.hit.disconnect(on_hit)
	animation_tree['parameters/playback'].travel('parry/end')
	animation_tree.animation_finished.connect(on_finished, CONNECT_ONE_SHOT)

func on_finished(_animation: String) -> void:
	is_finished = true
