extends Resource
class_name DamageData

@export var damage: float = 10
@export var damage_type: Globals.DAMAGE_TYPES
@export var damage_stats = DamageStats.new()

func copy() -> DamageData:
	var copy = DamageData.new()
	copy.damage = damage
	copy.damage_type = damage_type
	copy.damage_stats = damage_stats
	return copy

func get_damage() -> float:
	var d = damage
	for dm in damage_stats.damage_modifiers:
		if dm.get_type() == damage_type:
			d += damage * dm.get_value()
	return d

func mod_stats(stats: DamageStats) -> void:
	damage_stats.mod_stats(stats)

func mod_data(data: DamageData) -> void:
	damage += data.damage
	damage_type = data.damage_type
	damage_stats.mod_stats(data.damage_stats)

func get_type() -> Globals.DAMAGE_TYPES:
	return damage_type
