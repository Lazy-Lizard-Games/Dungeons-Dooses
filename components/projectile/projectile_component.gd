extends Node2D
class_name ProjectileComponent

@export var projectile: Projectile
@export var stats_component: StatsComponent

@onready var root = get_tree().root

func spawn_projectile(damage_data: DamageData, direction: Vector2) -> void:
	var final_damage
	if stats_component != null:
		final_damage = stats_component.apply_damage_modifiers(damage_data)
	else:
		final_damage = damage_data
	var projectile_scene = projectile.projectile_scene.instantiate()
	if projectile_scene.has_method("set_damage_data"):
		projectile_scene.set_damage_data(final_damage)
	if projectile_scene.has_method("set_direction"):
		projectile_scene.set_direction(direction)
	projectile_scene.global_position = global_position
	root.add_child(projectile_scene)
