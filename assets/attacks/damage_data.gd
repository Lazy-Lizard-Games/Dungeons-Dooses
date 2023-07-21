extends Resource
class_name DamageData

@export var damage: float:
	set(v):
		damage = v
		modified_damage = v
@export var damage_type: Globals.DAMAGE_TYPES

var modified_damage: float

func copy() -> DamageData:
	var copy = DamageData.new()
	copy.damage = damage
	copy.modified_damage = modified_damage
	copy.damage_type = damage_type
	return copy

func get_damage() -> float:
	return modified_damage

func mod_damage(value: float) -> void:
	modified_damage += damage * (value/100.0)

func get_type() -> Globals.DAMAGE_TYPES:
	return damage_type
