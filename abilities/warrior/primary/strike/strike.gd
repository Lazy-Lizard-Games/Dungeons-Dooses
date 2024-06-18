extends Ability

## Sweeps the sword in frnot of you, cleaving all those foolish enough to stand too close.

const DAMAGE_TYPE = Enums.DamageType.Slash

## The damage dealt by this ability.
@export var damage: float
## The knockback applied by this ability.
@export var knockback: float
## The projectile that will be created when the ability is casted.
@export var strike_projectile_scene: PackedScene

var angle: float = 0
var has_casted := false

func enter() -> void:
	mob.animation_player.play("strike_side")
	cast()

func process_physics(_delta: float) -> State:
	var current_position = mob.animation_player.current_animation_position

	if !has_casted:
		angle = mob.looking_at.angle()
		mob.sprite.flip_h = mob.looking_at.x < 0

	if angle > 2.36 or angle < - 2.36:
		mob.animation_player.play("strike_side") # left
	elif angle >= - 2.36 and angle < - 0.79:
		mob.animation_player.play("strike_up") # up
	elif angle >= - 0.79 and angle < 0.79:
		mob.animation_player.play("strike_side") # right
	else:
		mob.animation_player.play("strike_down") # down

	if current_position >= mob.animation_player.current_animation_length:
		return mob.state_component.starting_state
	mob.animation_player.seek(current_position)

	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	mob.velocity_component.accelerate_in_direction(direction * 0.1)
	mob.velocity_component.move(mob)

	return null

func exit() -> void:
	has_casted = false
	refresh()

func _on_casted() -> void:
	has_casted = true
	mob.stamina_component.exhaust(cost * mob.stats_component.ability_efficiency.get_final_value())
	var affinity = mob.stats_component.get_final_affinity_for(DAMAGE_TYPE)
	var damage_data = DamageData.new(damage * affinity, DAMAGE_TYPE)
	var impact_data = ImpactData.new([damage_data], knockback, [])
	var strike_projectile: Projectile = strike_projectile_scene.instantiate()
	strike_projectile.init(mob.centre_position, mob.looking_at, impact_data, mob.faction)
	ProjectileHandler.add_projectile(strike_projectile)

func _on_started() -> void:
	mob.state_component.change_state(self)