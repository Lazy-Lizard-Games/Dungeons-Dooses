extends Resource
class_name AbilityData

@export var weapon_type: Globals.WEAPON_TYPES
@export var ability_name: String
@export_multiline var ability_description: String
@export var icon: Texture2D
@export var animation: Animation
@export var projectile: PackedScene
@export var damage_stats = DamageStats.new()
@export var cooldown: float

func create_projectile() -> Node2D:
	var p = null
	if projectile:
		p = projectile.instantiate()
		p.mod_stats(damage_stats)
	return p

func get_ability_name() -> String:
	return ability_name

func get_description() -> String:
	return ability_description
