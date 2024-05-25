extends Ability

## Prepares the warrior to intercept an incoming attack. If successful, deflect the attack and quickly counter strike.


@export var player: Player
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer
@export var window_time: float

var has_casted = false
var has_countered = false
var has_ended = false
var window_timer = 0.0

func enter() -> void:
	cast()
	animation_player.play("parry_start")

func exit() -> void:
	has_casted = false
	has_countered = false
	has_ended = false
	window_timer = 0.0

func process_frame(delta: float) -> State:
	if has_casted and !has_countered and !has_ended:
		window_timer += delta
		if window_timer >= window_time:
			_on_window_timer_timeout()
	return null

func process_physics(_delta: float) -> State:
	player.velocity_component.accelerate_in_direction(Vector2.ZERO)
	player.velocity_component.move(player)
	return null

func _on_casted() -> void:
	has_casted = true
	player.hitbox_component.is_immune = true
	player.hitbox_component.impacted.connect(_on_player_hitbox_component_impacted)
	animation_player.play("parry_idle")

func _on_player_hitbox_component_impacted(_data: ImpactData, _from: HurtboxComponent, _immunity: bool) -> void:
	player.hitbox_component.impacted.disconnect(_on_player_hitbox_component_impacted)
	has_countered = true
	player.hitbox_component.is_immune = false
	animation_player.play("parry_attack")
	animation_player.animation_finished.connect(_on_animation_player_animation_finished)

func _on_window_timer_timeout() -> void:
	player.hitbox_component.impacted.disconnect(_on_player_hitbox_component_impacted)
	has_ended = true
	player.hitbox_component.is_immune = false
	animation_player.play("parry_end")
	animation_player.animation_finished.connect(_on_animation_player_animation_finished)

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	animation_player.animation_finished.disconnect(_on_animation_player_animation_finished)
	player.state_component.change_state(player.state_component.starting_state)
