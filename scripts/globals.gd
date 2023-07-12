extends Node


enum ITEM_TYPES {ITEM, ARMOUR, WEAPON, CONSUMABLE}
enum ARMOUR_TYPES {HEAD, BODY, HANDS, FEET}
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

func create_weapon(weapon_data: WeaponData) -> Sprite2D:
	var weapon = Sprite2D.new()
	weapon.texture = weapon_data.texture
	return weapon
