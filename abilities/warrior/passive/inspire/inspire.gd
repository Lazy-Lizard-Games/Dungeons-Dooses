extends Ability

## Inspire all nearby allies with increased attack and defence.

## The inspire effect which will be applied by the projectile.
@export var inspire_effect: InspireEffect
## The projectile which will be used to deliver the effect.
@export var projectile_scene: PackedScene

func init(ability: AbilityComponent) -> void:
	super(ability)
	cast()

func _on_casted():
	var duplicated_effect = inspire_effect.duplicate(true) as InspireEffect
	duplicated_effect.physical_affinity *= mob.stats_component.ability_power.get_final_value()
	var effect_data = EffectData.new(duplicated_effect, 1)
	var impact_data = ImpactData.new([], 0, [effect_data])
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.scale *= mob.stats_component.ability_range.get_final_value()
	projectile.init(mob.centre_position, mob.looking_at, impact_data, mob.faction, true)
	ProjectileHandler.add_projectile(projectile)
	cast()
