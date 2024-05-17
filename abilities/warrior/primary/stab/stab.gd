extends Ability

## Thrusts the sword forward, piercing hit enemies and reduces their physical resistance.

const DAMAGE_TYPE = Enums.DamageType.Pierce

@export var player: Player
## The damage dealt by this ability.
@export var damage: float
## The knockback applied by this ability.
@export var knockback: float
## The effect dealt by the ability.
@export var effect: Effect
## The chance that the effect will be applied.
@export_range(0, 1) var chance: float
## The projectile that will be created when the ability is casted.
@export var stab_projectile_scene: PackedScene
## State to move to when ability is casted.
@export var idle_state: State
## Velocity component which will update movement from inputs.
@export var velocity: VelocityComponent
## Animation tree which will play the animation.
@export var animation_player: AnimationPlayer
@export var sprite: Sprite2D

var angle: float = 0
var has_casted := false

func enter() -> void:
	animation_player.play("stab_side")
	cast()

func process_frame(delta: float) -> State:
	if state == AbilityState.Casting and !has_casted:
		casting_timer += delta * player.stats_component.cast_rate.get_final_value()
		if casting_timer >= casting_time:
			casting_timer -= casting_time
			has_casted = true
			casted.emit()
	return null

func process_physics(_delta: float) -> State:
	var current_position = animation_player.current_animation_position

	if !has_casted:
		angle = player.looking_at.angle()
		sprite.flip_h = player.looking_at.x < 0

	# Figure out which animation to play based on (22.5 deg)
	if angle >= 2.75 or angle < - 2.75:
		animation_player.play('stab_side') # left
	elif angle >= - 2.75 and angle < - 1.96:
		animation_player.play('stab_up_side') # top-left
	elif angle >= - 1.96 and angle < - 1.18:
		animation_player.play('stab_up') # top
	elif angle >= - 1.18 and angle < - 0.39:
		animation_player.play('stab_up_side') # top-right
	elif angle >= - 0.39 and angle < 0.39:
		animation_player.play('stab_side') # right
	elif angle >= 0.39 and angle < 1.18:
		animation_player.play('stab_down_side') # bottom-right
	elif angle >= 1.18 and angle < 1.96:
		animation_player.play('stab_down') # bottom
	else:
		animation_player.play('stab_down_side') # bottom-right

	if current_position >= animation_player.current_animation_length:
		return idle_state
	animation_player.seek(current_position)

	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity.accelerate_in_direction(direction * 0.1)
	velocity.move(player)
	return null

func exit() -> void:
	has_casted = false
	refresh()

func _on_casted():
	player.stamina_component.exhaust(cost * player.stats_component.ability_efficiency.get_final_value())
	var affinity = player.stats_component.get_damage_affinity(DAMAGE_TYPE)
	var damage_data = DamageData.new(damage * (1 + affinity.get_final_value()), DAMAGE_TYPE)
	var effect_data = EffectData.new(effect, chance)
	var impact_data = ImpactData.new([damage_data], knockback, [effect_data])
	var stab_projectile: Projectile = stab_projectile_scene.instantiate()
	stab_projectile.init(player.centre_position, player.looking_at, impact_data, player.faction, false)
	ProjectileHandler.add_projectile(stab_projectile)

func _on_refreshed():
	ready()
