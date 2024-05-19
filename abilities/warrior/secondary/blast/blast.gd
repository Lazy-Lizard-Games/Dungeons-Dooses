extends Ability

# Charged ability for firing shrapnel at enemies:
#   -> Hold to charge
#   -> Release to fire when charged

const DAMAGE_TYPE = Enums.DamageType.Slash

@export var player: Player
@export var idle_state: State
@export var damage: float
@export var effect: BleedingEffect
@export_range(0, 1) var chance: float
@export var knockback: float
@export var blast_projectile: PackedScene
@export var animation_player: AnimationPlayer
@export var sprite: Sprite2D

var has_casted := false
var has_fired := false
var angle: float = 0

func enter() -> void:
	animation_player.play("blast_charge_side")
	cast()

func exit() -> void:
	has_casted = false
	has_fired = false
	refresh()

func process_frame(_delta: float) -> State:
	if Input.is_action_just_released("ability_2"):
		if has_casted:
			if !has_fired:
				fire_projectile()
		else:
			return idle_state
	return null

func process_physics(_delta: float) -> State:

	var current_position = animation_player.current_animation_position

	if !has_fired:
		angle = player.looking_at.angle()
		update_animation('blast_charge', current_position)
	else:
		if current_position >= animation_player.current_animation_length:
			return idle_state

	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	player.velocity_component.accelerate_in_direction(direction * 0.1)
	player.velocity_component.move(player)

	return null

func fire_projectile() -> void:
	has_casted = false
	has_fired = true
	update_animation('blast_fire', 0)
	player.stamina_component.exhaust(cost * player.stats_component.ability_efficiency.get_final_value())
	var affinity = player.stats_component.get_damage_affinity(DAMAGE_TYPE).get_final_value()
	var damage_data = DamageData.new(damage * affinity, DAMAGE_TYPE)
	var effect_data = EffectData.new(effect, chance)
	var impact_data = ImpactData.new([damage_data], knockback, [effect_data])
	var projectile: Projectile = blast_projectile.instantiate()
	projectile.init(player.centre_position, player.looking_at, impact_data, player.faction, false)
	ProjectileHandler.add_projectile(projectile)

func update_animation(base: String, position: float) -> void:
	sprite.flip_h = player.looking_at.x < 0
	if angle >= 2.75 or angle < - 2.75:
		animation_player.play(base + '_side') # left
	elif angle >= - 2.75 and angle < - 1.96:
		animation_player.play(base + '_up_side') # top-left
	elif angle >= - 1.96 and angle < - 1.18:
		animation_player.play(base + '_up') # top
	elif angle >= - 1.18 and angle < - 0.39:
		animation_player.play(base + '_up_side') # top-right
	elif angle >= - 0.39 and angle < 0.39:
		animation_player.play(base + '_side') # right
	elif angle >= 0.39 and angle < 1.18:
		animation_player.play(base + '_down_side') # bottom-right
	elif angle >= 1.18 and angle < 1.96:
		animation_player.play(base + '_down') # bottom
	else:
		animation_player.play(base + '_down_side') # bottom-right
	animation_player.seek(position)

func _on_casted():
	has_casted = true
