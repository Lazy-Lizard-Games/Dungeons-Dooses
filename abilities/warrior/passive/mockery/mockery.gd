extends Ability

## Humiliate nearby enemies with your presence, reducing the physical damage they deal and making them likely to target you.

const UID = &"Mockery"

@export var player: Player
@export var threat: float
@export var mockery_effect: MockeryEffect
@export var projectile_scene: PackedScene

func enter() -> void:
	var threat_modifier = AttributeModifier.new(UID, Enums.OperationType.Addition, threat)
	player.stats_component.threat.add_modifier(threat_modifier)
	cast()

func exit() -> void:
	is_casting = false
	player.stats_component.threat.remove_modifier(UID)
	ready()

func _on_casted():
	var duplicated_effect = mockery_effect.duplicate(true) as MockeryEffect
	duplicated_effect.physical_affinity *= player.stats_component.ability_power.get_final_value()
	var effect_data = EffectData.new(duplicated_effect, 1)
	var impact_data = ImpactData.new([], 0, [effect_data])
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.scale *= player.stats_component.ability_range.get_final_value()
	projectile.init(player.centre_position, player.looking_at, impact_data, player.faction, false)
	ProjectileHandler.add_projectile(projectile)
	cast()