extends State

## Slime has found its next meal.

@export var slime: Slime
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer
@export var hunter: HunterComponent
@export var idle_state: State
@export var jump_interval: float
@export var jump_variance: float

var jump_time: float = 0
var jump_timer: float = 0.0
var is_jumping = false
var wait_time: float = 0.4
var wait_timer: float = 0.0
var target: TargetComponent

func jump() -> void:
	wait_timer = 0
	is_jumping = true
	animation_player.animation_finished.connect(_on_animation_player_animation_finished, CONNECT_ONE_SHOT)
	animation_player.play('jump_attack')

func move() -> void:
	var direction = slime.centre_position.direction_to(target.global_position)
	sprite.flip_h = direction.x < 0
	slime.velocity_component.add_velocity(direction * slime.velocity_component.speed * 1.5)

func idle() -> void:
	if animation_player.animation_finished.is_connected(idle):
		animation_player.animation_finished.disconnect(idle)
	jump_time = jump_interval + (randf() * jump_variance * 2) - jump_variance
	jump_timer = 0
	is_jumping = false
	animation_player.play('idle')

func choose_target(targets: Array[TargetComponent]) -> TargetComponent:
	var t_sum: float = 0
	for t in targets:
		t_sum += t.threat
	var limit = randf()
	for t in targets:
		limit -= (t.threat / t_sum)
		if limit <= 0:
			return t
	return targets[-1]

func enter() -> void:
	target = choose_target(hunter.targets)
	idle()

func process_frame(delta: float) -> State:
	if !is_jumping:
		jump_timer += delta
		if jump_timer >= jump_time:
			jump()
	return null

func process_physics(_delta: float) -> State:	
	if !hunter.is_hunting or !target:
		return idle_state
	slime.velocity_component.accelerate_in_direction(Vector2.ZERO)
	slime.velocity_component.move(slime)
	return null

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	idle()