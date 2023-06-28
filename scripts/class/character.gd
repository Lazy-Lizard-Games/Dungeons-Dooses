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
@export_category("Character Properties")
## Base health
@export var base_health = 10
## Base health multiplier
@export var base_health_mult = 1
## Base movement speed
@export var base_speed = 100
## Base movement speed multiplier
@export var base_speed_mult = 1
## Base defence
@export var base_defence = 0
## Base defence multiplier
@export var base_defence_mult = 1
## Base critical hit chance
@export var base_crit_chance = 0
## Base critical hit damage multiplier
@export var base_crit_mult = 1
## Base attack speed multiplier
@export var base_attack_mult = 1
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
	"health_current": 0,
	"speed": 0,
	"speed_mult": 0,
	"defence": 0,
	"defence_mult": 0,
	"crit_hit_chance": 0,
	"crit_hit_mult": 0,
	"attack_speed_mult": 0,
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

func reset_stats() -> void:
	set_stat("health", base_health)
	set_stat("health_mult", base_health_mult)
	set_stat("health_current", base_health)
	set_stat("speed", base_speed)
	set_stat("speed_mult", base_speed_mult)
	set_stat("defence", base_defence)
	set_stat("defence_mult", base_defence_mult)
	set_stat("crit_hit_chance", base_crit_chance)
	set_stat("crit_hit_mult", base_crit_mult)
	set_stat("attack_speed_mult", base_attack_mult)
	for type in base_damage_mults:
		set_damage_mult(types[type], base_damage_mults[type])
	for type in base_damage_resists:
		set_damage_resist(types[type], base_damage_resists[type])


func get_stat(stat: String) -> int:
	return stats[stat]

func get_damage_mult(type: Globals.DAMAGE_TYPES) -> int:
	return damage_mults[type]

func get_damage_resist(type: Globals.DAMAGE_TYPES) -> int:
	return damage_resists[type]

func set_stat(stat: String, value: int) -> void:
	if stats.has(stat):
		stats[stat] = value

func set_damage_mult(type: Globals.DAMAGE_TYPES, value: int) -> void:
	if damage_mults.has(type):
		damage_mults[type] = value

func set_damage_resist(type: Globals.DAMAGE_TYPES, value: int) -> void:
	if damage_resists.has(type):
		damage_resists[type] = value

func mod_stat(stat: String, value: int) -> void:
	if stats.has(stat):
		stats[stat] += value

func mod_damage_mult(type: Globals.DAMAGE_TYPES, value: int) -> void:
	if damage_mults.has(type):
		damage_mults[type] += value

func mod_damage_resist(type: Globals.DAMAGE_TYPES, value: int) -> void:
	if damage_resists.has(type):
		damage_resists[type] += value

func _ready() -> void:
	reset_stats()
	init_setup()

func init_setup() -> void:
	pass

