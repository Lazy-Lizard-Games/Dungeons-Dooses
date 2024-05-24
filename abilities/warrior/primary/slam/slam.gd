extends Ability

## Pierce the ground beneath your feet and slam it with all your might, knocking nearby enemies to the ground.

const DAMAGE_TYPE = Enums.DamageType.Blunt

## The player using the ability.
@export var player: Player
## The damage dealt by the ability.
@export var damage: float
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
	var affinity = player.stats_component.get_final_affinity_for(DAMAGE_TYPE)
	var damage_data = DamageData.new(damage * affinity, DAMAGE_TYPE)
	var impact_data = ImpactData.new([damage_data], knockback, [])
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.init(player.centre_position, player.looking_at, impact_data, player.faction)
	ProjectileHandler.add_projectile(projectile)
