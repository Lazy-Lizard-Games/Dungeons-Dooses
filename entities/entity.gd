extends CharacterBody2D
class_name Entity

## Triggered when the entities faction changes for whatever reason. Useful for charming enemies and such.
signal faction_changed(faction: Globals.FACTION)

@export var id := ""
@export var faction := Globals.FACTION.NONE:
	set(f):
		faction = f
		faction_changed.emit(faction)
@export var xp := 0
