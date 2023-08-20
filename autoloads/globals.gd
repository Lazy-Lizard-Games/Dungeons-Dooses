extends Node

enum FACTIONS 
{
	NONE,
	PLAYER, 
	HUMAN, 
	CREATURE, 
	MONSTER,
}

enum DAMAGE_TYPES 
{
	PHYSICAL, 
	FIRE, 
	FROST, 
	POISON, 
	SHOCK, 
	EXPLOSION,
}

enum STAT_TYPES 
{
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
