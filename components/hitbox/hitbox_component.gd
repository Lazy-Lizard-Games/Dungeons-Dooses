extends Area2D
class_name HitboxComponent

signal hit_by_projectile(projectile, final_damage)
signal hit_by_hitbox(hitbox_component: HitboxComponent)

@export var health_component: HealthComponent
@export var stats_component: StatsComponent
@export var faction: Globals.FACTIONS = 0
@export var detect_only: bool = false
@export var damage: float = 1


func can_accept_collisions() -> bool:
	return health_component.has_health_remaining if health_component != null else false

# projectile is ProjectileComponent
func handle_projectile_collision(projectile) -> void:
	var damage = 0.0
	if not detect_only:
		damage = projectile.damage
		damage = deal_damage_with_transforms(damage, projectile.damage_type)
	hit_by_projectile.emit(projectile, damage)

func deal_damage_with_transforms(damage: float, damage_type: Globals.DAMAGE_TYPES) -> float:
	var final_damage = stats_component.transform_damage(damage, damage_type) if stats_component != null \
			 else damage
	if health_component != null: health_component.damage(damage)
	return final_damage

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		if not detect_only and area.faction != faction:
			deal_damage_with_transforms(area.damage, Globals.DAMAGE_TYPES.PHYSICAL)
		hit_by_hitbox.emit(area)
