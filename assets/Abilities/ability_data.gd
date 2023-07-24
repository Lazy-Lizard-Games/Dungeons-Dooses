extends Resource
class_name AbilityData

@export var weapon_type: Globals.WEAPON_TYPES
@export var name: String
@export var animation: Animation
@export var projectile: PackedScene
@export var damage_stats = DamageStats.new()
@export var cooldown: float

func create_projectile() -> Node2D:
	var p = projectile.instantiate()
	p.mod_stats(damage_stats)
	return p
