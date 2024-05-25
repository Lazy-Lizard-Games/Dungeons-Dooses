extends State

## Slime idly roams its territory looking for food.

@export var slime: Slime
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer
@export var jump_interval: float
@export var jump_variance: float

var jump_time: float = 0
var jump_timer: float = 0.0
var is_jumping = false
var wait_time: float = 0.4
var wait_timer: float = 0.0

func jump() -> void:
	wait_timer = 0
	is_jumping = true
	animation_player.animation_finished.connect(_on_animation_player_animation_finished, CONNECT_ONE_SHOT)
	animation_player.play('jump')

func move() -> void:
	var direction = Vector2(randf() - 0.5, randf() - 0.5).normalized()
	sprite.flip_h = direction.x < 0
	slime.velocity_component.add_velocity(direction * slime.velocity_component.speed)

func idle() -> void:
	if animation_player.animation_finished.is_connected(idle):
		animation_player.animation_finished.disconnect(idle)
	jump_time = jump_interval + (randf() * jump_variance * 2) - jump_variance
	jump_timer = 0
	is_jumping = false
	animation_player.play('idle')

func enter() -> void:
	idle()

func process_frame(delta: float) -> State:
	if !is_jumping:
		jump_timer += delta
		if jump_timer >= jump_time:
			jump()
	return null

func process_physics(_delta: float) -> State:	
	slime.velocity_component.accelerate_in_direction(Vector2.ZERO)
	slime.velocity_component.move(slime)
	return null

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	idle()