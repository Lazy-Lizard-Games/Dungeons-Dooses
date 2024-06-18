extends Ability

## Your divine presence encourages nearby allies to heal faster.

## The mend effect which will be applied by the projectile.
@export var vigour_effect: VigourEffect
## The projectile which will be used to deliver the effect.
@export var projectile_scene: PackedScene

func init(ability: AbilityComponent) -> void:
	super(ability)
	cast()

func _on_casted():
	var duplicated_effect = vigour_effect.duplicate(true) as VigourEffect
	duplicated_effect.stamina_regeneration *= mob.stats_component.ability_power.get_final_value()
	var effect_data = EffectData.new(duplicated_effect, 1)
	var impact_data = ImpactData.new([], 0, [effect_data])
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.scale *= mob.stats_component.ability_range.get_final_value()
	projectile.init(mob.centre_position, mob.looking_at, impact_data, mob.faction, true)
	ProjectileHandler.add_projectile(projectile)
	cast()
