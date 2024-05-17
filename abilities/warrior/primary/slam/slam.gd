extends Ability

## Pierce the ground beneath your feet and slam it with all your might, knocking nearby enemies to the ground.

const DAMAGE_TYPE = Enums.DamageType.Blunt

## The player using the ability.
@export var player: Player
## The damage dealt by the ability.
@export var damage: float
## The effect applied by the ability.
@export var effect: Effect
## The chance of applying the effect.
@export_range(0, 1) var chance: float
## The knockback applied by the ability.
@export var knockback: float
## The projectile that will deliver the impact.
@export var projectile_scene: PackedScene
## The state moved to when the ability has finished.
@export var idle_state: State
## Plays the animations for the ability.
@export var animation_player: AnimationPlayer

var has_casted := false

func enter() -> void:
	animation_player.play('slam')
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
	if animation_player.current_animation_position >= animation_player.current_animation_length:
		return idle_state
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	player.velocity_component.accelerate_in_direction(direction * 0.1)
	player.velocity_component.move(player)
	return null

func exit() -> void:
	has_casted = false
	refresh()

func _on_casted():
	player.stamina_component.exhaust(cost * player.stats_component.ability_efficiency.get_final_value())
	var affinity_modifier = 1 + player.stats_component.get_damage_affinity(DAMAGE_TYPE).get_final_value()
	var damage_data = DamageData.new(damage * affinity_modifier, DAMAGE_TYPE)
	var effect_data = EffectData.new(effect.duplicate(true), chance)
	var impact_data = ImpactData.new([damage_data], knockback, [effect_data])
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.init(player.centre_position, player.looking_at, impact_data, player.faction)
	ProjectileHandler.add_projectile(projectile)

func _on_refreshed():
	ready()
