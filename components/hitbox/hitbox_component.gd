extends Area2D
class_name HitboxComponent

signal hit_by_hurtbox(hitbox_component: HitboxComponent, final_damage: DamageData)

@export var health_component: HealthComponent
@export var stats_component: StatsComponent
@export var faction: Globals.FACTIONS = 0
@export var detect_only: bool = false


func can_accept_collisions() -> bool:
	return health_component.has_health_remaining if health_component != null else false

func handle_hurbox_collision(hurtbox) -> void:
	var final_damage = 0.0
	if not detect_only:
		for damage_data in hurtbox.damage_datas:
			final_damage += deal_damage_with_transforms(damage_data).damage
	hit_by_hurtbox.emit(hurtbox, final_damage)

func deal_damage_with_transforms(damage: DamageData) -> DamageData:
	var final_damage = stats_component.apply_damage_resistances(damage) if stats_component != null \
			 else damage
	if health_component != null: health_component.damage(final_damage.damage)
	return final_damage
