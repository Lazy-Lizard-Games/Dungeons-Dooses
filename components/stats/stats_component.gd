extends Node
class_name StatsComponent

## Resource stats
@export_category("Resources")
@export var health_mult: float = 1.0
@export var health_regen: float = 1
@export var health_regen_mult: float = 1.0
@export var stamina_mult: float = 1.0
@export var stamina_regen: float = 1
@export var stamina_regen_mult: float = 1.0
## Mobility stats
@export_category("Mobility")
@export var move_speed_mult: float = 1.0
@export var accelerate_mult: float = 1.0
## Combat stats
@export_category("Combat")
@export var damage_mult: float = 1.0
@export var defence_mult: float = 1.0
@export var attack_speed_mult: float = 1.0
@export var stamina_cost_mult: float = 1.0
## Damage-In multipliers
@export_category("Resistances")
@export var damage_resistances: Array[ResistModifier]
## Damage-Out multipliers
@export_category("Modifiers")
@export var damage_modifiers: Array[DamageModifier]


func apply_damage_resistances(damage: DamageData) -> DamageData:
	var final_damage = damage.copy()
	for resist in damage_resistances:
		if resist.type == damage.type:
			final_damage.damage *= resist.value
	return final_damage

func apply_damage_modifiers(damage: DamageData) -> DamageData:
	var final_damage = damage.copy()
	for mod in damage_modifiers:
		if mod.type == damage.type:
			final_damage.damage *= mod.value
	final_damage.damage *= damage_mult
	return final_damage
