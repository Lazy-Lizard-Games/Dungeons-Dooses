extends Node

enum STATUS { ALLY, FOE }

var relations: Dictionary = {
	Globals.FACTIONS.NONE : {
		STATUS.ALLY : [],
		STATUS.FOE : [],
	},
	Globals.FACTIONS.PLAYER: {
		STATUS.ALLY : [Globals.FACTIONS.PLAYER],
		STATUS.FOE : [],
	},
	Globals.FACTIONS.HUMAN : {
		STATUS.ALLY : [Globals.FACTIONS.HUMAN],
		STATUS.FOE : [Globals.FACTIONS.CREATURE, Globals.FACTIONS.MONSTER],
	},
	Globals.FACTIONS.CREATURE : {
		STATUS.ALLY : [Globals.FACTIONS.CREATURE],
		STATUS.FOE : [Globals.FACTIONS.PLAYER, Globals.FACTIONS.HUMAN, Globals.FACTIONS.MONSTER],
	},
	Globals.FACTIONS.MONSTER : {
		STATUS.ALLY : [Globals.FACTIONS.MONSTER],
		STATUS.FOE : [Globals.FACTIONS.PLAYER, Globals.FACTIONS.HUMAN, Globals.FACTIONS.CREATURE],
	},
}

func get_allies_for(faction: Globals.FACTIONS) -> Array:
	var factions = relations.get(faction).get(STATUS.ALLY)
	return factions

func get_foes_for(faction: Globals.FACTIONS) -> Array:
	var factions = relations.get(faction).get(STATUS.FOE)
	return factions
