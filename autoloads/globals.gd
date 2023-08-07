extends Node

@onready var weapon_scene = preload("res://scenes/weapon/weapon.tscn")

enum FACTIONS {NONE, HUMAN, CREATURE, MONSTER}
enum ITEM_TYPES {ITEM, ARMOUR, WEAPON, CONSUMABLE}
enum ARMOUR_TYPES {HEAD, BODY, HANDS, FEET}
enum WEAPON_TYPES {SWORD, AXE, MACE, SPEAR, DAGGER, GREAT_SWORD, GREAT_AXE, FIRE, FROST, SHOCK, CHARACTER}
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

var known_abilities: Dictionary = {
	"character": [],
}

func add_ability(ability: AbilityData) -> void:
	var type: String = WEAPON_TYPES.keys()[ability.weapon_type].to_lower()
	if known_abilities.has(type):
		if known_abilities[type].has(ability):
			print("Ability already known!")
		else:
			known_abilities[type].append(ability)
			print("Ability added to known type!")
	else:
		known_abilities[type] = [ability]
		print("Ability added to new type!")

func get_abilities(type: WEAPON_TYPES) -> Array:
	var type_string = WEAPON_TYPES.keys()[type].to_lower()
	if known_abilities.has(type_string):
		return known_abilities[type_string]
	else:
		return []



