extends Ability

## Humiliate nearby enemies with your presence, reducing the physical damage they deal and making them likely to target you.

const UID = &"Mockery"

@export var threat: float
@export var mockery_effect: MockeryEffect
@export var projectile_scene: PackedScene

func init(ability: AbilityComponent) -> void:
	super(ability)
	cast()

func _on_casted():
	var duplicated_effect = mockery_effect.duplicate(true) as MockeryEffect
	duplicated_effect.physical_affinity *= mob.stats_component.ability_power.get_final_value()
	var effect_data = EffectData.new(duplicated_effect, 1)
	var impact_data = ImpactData.new([], 0, [effect_data])
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.scale *= mob.stats_component.ability_range.get_final_value()
	projectile.init(mob.centre_position, mob.looking_at, impact_data, mob.faction, false)
	ProjectileHandler.add_projectile(projectile)
	cast()