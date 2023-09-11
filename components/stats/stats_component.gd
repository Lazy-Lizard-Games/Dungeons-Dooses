extends Node
class_name StatsComponent

@export_category("Stats")
@export var max_health: float = 10
@export var health_regen: float = 1
@export var max_stamina: float = 10
@export var stamina_regen: float = 1
@export_category("Stat Multipliers")
@export var health_mult: float = 1.0
@export var health_regen_mult: float = 1.0
@export var stamina_mult: float = 1.0
@export var stamina_regen_mult: float = 1.0
@export var attack_speed_mult: float = 1.0
@export var move_speed_mult: float = 1.0
@export var accelerate_mult: float = 1.0
@export var defence_mult: float = 1.0

@export_category("Damage Multipliers")
## Array of damage resistances applied when recieving damage
@export var damage_resistances: Array[ResistModifier]
## Array of damage multipliers applied when dealing damage
@export var damage_modifiers: Array[DamageModifier]

# TODO
# Handle stat modifiers (add, remove)

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
	return final_damage
