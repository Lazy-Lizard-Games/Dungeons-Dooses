extends Ability

## Prepares the warrior to intercept an incoming attack. If successful, deflect the attack and quickly counter strike.

@export var window_time: float

var has_casted = false
var has_countered = false
var has_ended = false
var window_timer = 0.0

func enter() -> void:
	cast()
	mob.animation_player.play("parry_start")

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
	mob.velocity_component.accelerate_in_direction(Vector2.ZERO)
	mob.velocity_component.move(mob)
	return null

func _on_casted() -> void:
	has_casted = true
	mob.hitbox_component.is_immune = true
	mob.hitbox_component.impacted.connect(_on_mob_hitbox_component_impacted)
	mob.animation_player.play("parry_idle")

func _on_mob_hitbox_component_impacted(_data: ImpactData, _from: HurtboxComponent, _immunity: bool) -> void:
	mob.hitbox_component.impacted.disconnect(_on_mob_hitbox_component_impacted)
	has_countered = true
	mob.hitbox_component.is_immune = false
	mob.animation_player.play("parry_attack")
	mob.animation_player.animation_finished.connect(_on_mob_animation_player_animation_finished)

func _on_window_timer_timeout() -> void:
	mob.hitbox_component.impacted.disconnect(_on_mob_hitbox_component_impacted)
	has_ended = true
	mob.hitbox_component.is_immune = false
	mob.animation_player.play("parry_end")
	mob.animation_player.animation_finished.connect(_on_mob_animation_player_animation_finished)

func _on_mob_animation_player_animation_finished(_anim_name: StringName) -> void:
	mob.animation_player.animation_finished.disconnect(_on_mob_animation_player_animation_finished)
	mob.state_component.change_state(mob.state_component.starting_state)

func _on_started() -> void:
	mob.state_component.change_state(self)