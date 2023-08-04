extends CharacterBody2D
class_name Character

var types = {
	"Physical": Globals.DAMAGE_TYPES.PHYSICAL,
	"Fire": Globals.DAMAGE_TYPES.FIRE,
	"Frost": Globals.DAMAGE_TYPES.FROST,
	"Shock": Globals.DAMAGE_TYPES.SHOCK,
	"Poison": Globals.DAMAGE_TYPES.POISON,
	"Explosion": Globals.DAMAGE_TYPES.EXPLOSION,
}

## Base character stats
@export var character_name: String
@export_category("Character Properties")
@export_group("Resources")
@export_subgroup("Health")
## Base health
@export var base_health = 10
## Base health multiplier
@export var base_health_mult = 1
## Base health regen
@export var base_health_regen = 1
@export_subgroup("Mana")
## Base mana
@export var base_mana = 10
## Base mana multiplier
@export var base_mana_mult = 1
## Base mana regen
@export var base_mana_regen = 1
@export_subgroup("Stamina")
## Base stamina
@export var base_stamina = 10
## Base stamina multiplier
@export var base_stamina_mult = 1
## Base stamina regen
@export var base_stamina_regen = 1

@export_group("General")
## Base movement speed
@export var base_speed = 100
## Base movement speed multiplier
@export var base_speed_mult = 1
## Base defence
@export var base_defence = 0
## Base defence multiplier
@export var base_defence_mult = 1

@export_group("Damage")
## Base critical hit chance
@export var base_crit_chance = 0
## Base critical hit damage multiplier
@export var base_crit_mult = 1
## Base damage type multipliers
@export var base_damage_mults: Dictionary = {
	"Physical": 0,
	"Fire": 0,
	"Frost": 0,
	"Shock": 0,
	"Poison": 0,
	"Explosion": 0,
}
## Base damage resistance multipliers
@export var base_damage_resists: Dictionary = {
	"Physical": 0,
	"Fire": 0,
	"Frost": 0,
	"Shock": 0,
	"Poison": 0,
	"Explosion": 0,
}

var stats = {
	"health": 0,
	"health_mult": 0,
	"health_max": 0,
	"mana": 0,
	"mana_mult": 0,
	"mana_max": 0,
	"stamina": 0,
	"stamina_mult": 0,
	"stamina_max": 0,
	"speed": 0,
	"speed_mult": 0,
	"defence": 0,
	"defence_mult": 0,
	"crit_chance": 0,
	"crit_mult": 0,
}

var damage_mults = {
	Globals.DAMAGE_TYPES.PHYSICAL: 0,
	Globals.DAMAGE_TYPES.FIRE: 0,
	Globals.DAMAGE_TYPES.FROST: 0,
	Globals.DAMAGE_TYPES.SHOCK: 0,
	Globals.DAMAGE_TYPES.POISON: 0,
	Globals.DAMAGE_TYPES.EXPLOSION: 0,
}
var damage_resists = {
	Globals.DAMAGE_TYPES.PHYSICAL: 0,
	Globals.DAMAGE_TYPES.FIRE: 0,
	Globals.DAMAGE_TYPES.FROST: 0,
	Globals.DAMAGE_TYPES.SHOCK: 0,
	Globals.DAMAGE_TYPES.POISON: 0,
	Globals.DAMAGE_TYPES.EXPLOSION: 0,
}
var effects: Array[Effect] = []

func reset_resources() -> void:
	set_stat("health", get_stat("health_max"))
	set_stat("mana", get_stat("mana_max"))
	set_stat("stamina", get_stat("stamina_max"))

func reset_stats() -> void:
	set_stat("health_mult", base_health_mult)
	set_stat("health_max", base_health)
	set_stat("speed", base_speed)
	set_stat("speed_mult", base_speed_mult)
	set_stat("defence", base_defence)
	set_stat("defence_mult", base_defence_mult)
	set_stat("crit_chance", base_crit_chance)
	set_stat("crit_mult", base_crit_mult)
	for type in base_damage_mults:
		set_damage_mult(types[type], base_damage_mults[type])
	for type in base_damage_resists:
		set_damage_resist(types[type], base_damage_resists[type])

func get_stat(stat: String) -> float:
	return stats[stat]

func get_damage_mult(type: Globals.DAMAGE_TYPES) -> float:
	return damage_mults[type]

func get_damage_resist(type: Globals.DAMAGE_TYPES) -> float:
	return damage_resists[type]

func set_stat(stat: String, value: float) -> void:
	if stats.has(stat):
		stats[stat] = value

func set_damage_mult(type: Globals.DAMAGE_TYPES, value: float) -> void:
	if damage_mults.has(type):
		damage_mults[type] = value

func set_damage_resist(type: Globals.DAMAGE_TYPES, value: float) -> void:
	if damage_resists.has(type):
		damage_resists[type] = value

func mod_stat(stat: String, value: float) -> void:
	if stats.has(stat):
		stats[stat] += value

func mod_damage_mult(type: Globals.DAMAGE_TYPES, value: float) -> void:
	if damage_mults.has(type):
		damage_mults[type] += value

func mod_damage_resist(type: Globals.DAMAGE_TYPES, value: float) -> void:
	if damage_resists.has(type):
		damage_resists[type] += value

func get_damage_stats() -> DamageStats:
	var ds = DamageStats.new()
	ds.crit_chance = get_stat("crit_chance")
	ds.crit_mult = get_stat("crit_mult")
	for type in damage_mults:
		var dm = DamageModifier.new()
		dm.type = type
		dm.value = get_damage_mult(type)
		ds.damage_modifiers.append(dm)
	for effect in effects:
		ds.effects.append(effect)
	return ds

func _ready() -> void:
	reset_stats()
	reset_resources()
	init_setup()

func init_setup() -> void:
	pass

func damage(damage_data: DamageData) -> void:
	print("Hit for %s of type %s" % [damage_data.get_damage(), damage_data.get_type()])

func get_item_name() -> String:
	return character_name
