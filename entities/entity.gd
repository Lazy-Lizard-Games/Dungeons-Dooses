extends CharacterBody2D
class_name Entity

signal faction_changed(faction: Globals.FACTION)

@export var id := ""
@export var faction := Globals.FACTION.NONE:
	set(f):
		faction = f
		faction_changed.emit(faction)
@export var xp := 0
