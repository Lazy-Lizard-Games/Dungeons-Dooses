extends Ability

## Inspire all nearby allies with increased attack and defence.

## The player using/affected by this ability.
@export var player: Player
## The inspire effect which will be applied by the projectile.
@export var inspire_effect: InspireEffect
## The projectile which will be used to deliver the effect.
@export var projectile_scene: PackedScene

func enter() -> void:
	cast()

func process_frame(delta: float) -> State:
	if state == AbilityState.Casting:
		casting_timer += delta * player.stats_component.cast_rate.get_final_value()
		if casting_timer >= casting_time:
			casting_timer -= casting_time
			casted.emit()
	return null

func exit() -> void:
	ready()

func _on_casted():
	var duplicated_effect = inspire_effect.duplicate(true) as InspireEffect
	duplicated_effect.physical_resistance *= player.stats_component.ability_power.get_final_value()
	duplicated_effect.physical_affinity *= player.stats_component.ability_power.get_final_value()
	var effect_data = EffectData.new(duplicated_effect, 1)
	var impact_data = ImpactData.new([], 0, [effect_data])
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.init(player.centre_position, player.looking_at, impact_data, player.faction, true)
	ProjectileHandler.add_projectile(projectile)
