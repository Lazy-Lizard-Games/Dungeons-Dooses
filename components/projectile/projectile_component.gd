extends Node2D
class_name ProjectileComponent

@export var projectile_scene: PackedScene
@export var stats_component: StatsComponent

@onready var root = get_tree().root

func spawn_projectile(damage_datas: Array[DamageData], direction: Vector2, faction: Globals.FACTIONS) -> void:
	var final_damage_datas: Array[DamageData]
	if stats_component:
		final_damage_datas = transform_damage_datas(damage_datas)
	var projectile = projectile_scene.instantiate()
	projectile.set_damage_datas(final_damage_datas)
	projectile.set_direction(direction)
	projectile.faction = faction
	projectile.global_position = global_position
	root.add_child(projectile)

func transform_damage_datas(damage_datas: Array[DamageData]) -> Array[DamageData]:
	@warning_ignore("unassigned_variable")
	var final_damage_datas: Array[DamageData]
	for damage_data in damage_datas:
		final_damage_datas.append(stats_component.apply_damage_modifiers(damage_data))
	return final_damage_datas
