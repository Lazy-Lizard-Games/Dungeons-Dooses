class_name StatsComponent
extends Node

## Stores the stats for an entity, especially useful when handling impacts and applying effects.

@export_category("General Stats")
@export var health_maximum := Attribute.new(1, 0)
@export var health_regeneration := Attribute.new(1, 0)
@export var health_delay := Attribute.new(1, 0)
@export var stamina_maximum := Attribute.new(1, 0)
@export var stamina_regeneration := Attribute.new(1, 0)
@export var stamina_delay := Attribute.new(1, 0)
@export var movement_speed := Attribute.new(1, 0)
@export var movement_acceleration := Attribute.new(1, 0)
@export var movement_friction := Attribute.new(1, 0)
@export_category("Ability Stats")
@export var ability_power := Attribute.new(1, 0)
@export var ability_efficiency := Attribute.new(1, 0)
@export var ability_duration := Attribute.new(1, 0)
@export var ability_range := Attribute.new(1, 0)
@export var charge_rate := Attribute.new(1, 0)
@export var cast_rate := Attribute.new(1, 0)
@export var refresh_rate := Attribute.new(1, 0)
@export_category("Offensive Stats")
@export var knockback_affinity := Attribute.new(0, 0)
@export var slash_affinity := Attribute.new(0, 0)
@export var pierce_affinity := Attribute.new(0, 0)
@export var blunt_affinity := Attribute.new(0, 0)
@export var fire_affinity := Attribute.new(0, 0)
@export var frost_affinity := Attribute.new(0, 0)
@export var shock_affinity := Attribute.new(0, 0)
@export var poison_affinity := Attribute.new(0, 0)
@export_category("Defensive Stats")
@export var knockback_resistance := Attribute.new(0, 0)
@export var slash_resistance := Attribute.new(0, 0)
@export var pierce_resistance := Attribute.new(0, 0)
@export var blunt_resistance := Attribute.new(0, 0)
@export var fire_resistance := Attribute.new(0, 0)
@export var frost_resistance := Attribute.new(0, 0)
@export var shock_resistance := Attribute.new(0, 0)
@export var poison_resistance := Attribute.new(0, 0)

func get_damage_affinity(type: Enums.DamageType) -> Attribute:
	match type:
		Enums.DamageType.Slash:
			return slash_affinity
		Enums.DamageType.Pierce:
			return pierce_affinity
		Enums.DamageType.Blunt:
			return blunt_affinity
		Enums.DamageType.Fire:
			return fire_affinity
		Enums.DamageType.Frost:
			return frost_affinity
		Enums.DamageType.Shock:
			return shock_affinity
		Enums.DamageType.Poison:
			return poison_affinity
		_:
			return Attribute.new()

func get_damage_resistance(type: Enums.DamageType) -> Attribute:
	match type:
		Enums.DamageType.Slash:
			return slash_resistance
		Enums.DamageType.Pierce:
			return pierce_resistance
		Enums.DamageType.Blunt:
			return blunt_resistance
		Enums.DamageType.Fire:
			return fire_resistance
		Enums.DamageType.Frost:
			return frost_resistance
		Enums.DamageType.Shock:
			return shock_resistance
		Enums.DamageType.Poison:
			return poison_resistance
		_:
			return Attribute.new()