extends Node

@onready var weapon_scene = preload("res://scenes/weapon/weapon.tscn")

enum ITEM_TYPES {ITEM, ARMOUR, WEAPON, CONSUMABLE}
enum ARMOUR_TYPES {HEAD, BODY, HANDS, FEET}
enum WEAPON_TYPES {SWORD, AXE, MACE, SPEAR, DAGGER}
enum DAMAGE_TYPES {PHYSICAL, FIRE, FROST, SHOCK, POISON, EXPLOSION}
enum STAT_TYPES {
	HEALTH,
	HEALTH_MULT,
	SPEED,
	SPEED_MULT,
	DEFENCE,
	DEFENCE_MULT,
	CRIT_HIT_CHANCE,
	CRIT_HIT_MULT,
	ATTACK_SPEED_MULT,
}

var STATS = [
	"health",
	"health_mult",
	"speed",
	"speed_mult",
	"defence",
	"defence_mult",
	"crit_hit_chance",
	"crit_hit_mult",
	"attack_speed_mult",
]

func create_weapon(weapon_data: WeaponData, parent: Character) -> Node2D:
	var weapon = weapon_scene.instantiate()
	weapon.setup()
	weapon.load_data(weapon_data, parent)
	return weapon
