extends Ability

## Pierce the ground beneath your feet and slam it with all your might, knocking nearby enemies to the ground.

const DAMAGE_TYPE = Enums.DamageType.Blunt

## The player using the ability.
@export var player: Player
## The damage dealt by the ability.
@export var damage: float
## The effect applied by the ability.
@export var effect: Effect
## The knockback applied by the ability.
@export var knockback: float
## The projectile that will deliver the impact.
@export var projectile_scene: PackedScene
## The state moved to when the ability has finished.
@export var idle_state: State

var is_finished: bool

var cost_modifier: float:
	get:
		if stats_component:
			return stats_component.ability_efficiency.get_final_value()
		return 1

func enter() -> void:
	player.animation_tree['parameters/playback'].travel('slam')
	player.animation_tree.animation_finished.connect(_on_animation_tree_animation_finished, CONNECT_ONE_SHOT)
	cast()

func process_physics(_delta: float) -> State:
	if is_finished:
		return idle_state
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	player.velocity_component.accelerate_in_direction(direction * 0.1)
	player.velocity_component.move(player)
	return null

func exit() -> void:
	is_finished = false
	refresh()

func _on_animation_tree_animation_finished(_anim_name: StringName) -> void:
	is_finished = true

func _on_casted():
	player.stamina_component.exhaust(cost * cost_modifier)
	var affinity_modifier = 1 + stats_component.get_damage_affinity(DAMAGE_TYPE).get_final_value()
	var damage_data = DamageData.new(damage * affinity_modifier, DAMAGE_TYPE)
	var effect_data = EffectData.new(effect.duplicate(true), 1)
	var impact_data = ImpactData.new([damage_data], knockback, [effect_data])
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.init(player.centre_position, player.looking_at, impact_data, player.faction)
	ProjectileHandler.add_projectile(projectile)

func _on_refreshed():
	ready()
