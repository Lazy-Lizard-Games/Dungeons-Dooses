extends Ability

## Sweeps the sword in frnot of you, cleaving all those foolish enough to stand too close.

const DAMAGE_TYPE = Enums.DamageType.Slash

@export var player: Player
## The damage dealt by this ability.
@export var damage: float
## The knockback applied by this ability.
@export var knockback: float
## The effect applied by this ability.
@export var effect: Effect
## The chance that the effect will be applied.
@export_range(0, 1) var chance: float
## The projectile that will be created when the ability is casted.
@export var strike_projectile_scene: PackedScene
## The time in seconds it takes to charge the ability.
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
	animation_player.play("strike_side")
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

	if angle > 2.36 or angle < - 2.36:
		animation_player.play("strike_side") # left
	elif angle >= - 2.36 and angle < - 0.79:
		animation_player.play("strike_up") # up
	elif angle >= - 0.79 and angle < 0.79:
		animation_player.play("strike_side") # right
	else:
		animation_player.play("strike_down") # down

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
	var strike_projectile: Projectile = strike_projectile_scene.instantiate()
	strike_projectile.init(player.centre_position, player.looking_at, impact_data, player.faction)
	ProjectileHandler.add_projectile(strike_projectile)

func _on_refreshed():
	ready()
