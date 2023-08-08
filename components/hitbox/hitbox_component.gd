extends Area2D
class_name HitboxComponent

signal hit_by_projectile(projectile, final_damage: DamageData)
signal hit_by_hurtbox(hitbox_component: HitboxComponent, final_damage: DamageData)

@export var health_component: HealthComponent
@export var stats_component: StatsComponent
@export var faction: Globals.FACTIONS = 0
@export var detect_only: bool = false


func can_accept_collisions() -> bool:
	return health_component.has_health_remaining if health_component != null else false

# projectile is ProjectileComponent
func handle_projectile_collision(projectile) -> void:
	var damage = 0.0
	if not detect_only:
		damage = projectile.damage
		damage = deal_damage_with_transforms(damage)
	hit_by_projectile.emit(projectile, damage)

func handle_hurbox_collision(hurtbox) -> void:
	var damage = 0.0
	if not detect_only:
		damage = hurtbox.damage
		damage = deal_damage_with_transforms(damage)
	hit_by_hurtbox.emit(hurtbox, damage)

func deal_damage_with_transforms(damage: DamageData) -> DamageData:
	var final_damage = stats_component.apply_damage_resistances(damage) if stats_component != null \
			 else damage
	if health_component != null: health_component.damage(final_damage.damage)
	return final_damage
