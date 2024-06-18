extends Ability

## Pierce the ground beneath your feet and slam it with all your might, knocking nearby enemies to the ground.

const DAMAGE_TYPE = Enums.DamageType.Blunt

## The damage dealt by the ability.
@export var damage: float
## The knockback applied by the ability.
@export var knockback: float
## The projectile that will deliver the impact.
@export var projectile_scene: PackedScene

var has_casted := false
var direction: Vector2

func init(ability: AbilityComponent) -> void:
	super(ability)

func enter() -> void:
	direction = mob.looking_at
	mob.sprite.flip_h = direction.x < 0
	mob.animation_player.play('slam')
	cast()

func process_physics(_delta: float) -> State:
	if mob.animation_player.current_animation_position >= mob.animation_player.current_animation_length:
		return mob.state_component.starting_state
	var move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	mob.velocity_component.accelerate_in_direction(move_direction * 0.1)
	mob.velocity_component.move(mob)
	return null

func exit() -> void:
	has_casted = false
	refresh()

func _on_casted():
	mob.stamina_component.exhaust(cost * mob.stats_component.ability_efficiency.get_final_value())
	var affinity = mob.stats_component.get_final_affinity_for(DAMAGE_TYPE)
	var damage_data = DamageData.new(damage * affinity, DAMAGE_TYPE)
	var impact_data = ImpactData.new([damage_data], knockback, [])
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.init(mob.centre_position, direction, impact_data, mob.faction)
	ProjectileHandler.add_projectile(projectile)

func _on_started() -> void:
	mob.state_component.change_state(self)