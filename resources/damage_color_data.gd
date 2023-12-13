extends Resource
class_name DamageColorData

@export var normal := Color.GRAY
@export var fire := Color.RED
@export var frost := Color.BLUE
@export var shock := Color.YELLOW
@export var poison := Color.GREEN


func getColorForType(type: Globals.DAMAGE) -> Color:
	match type:
		Globals.DAMAGE.NORMAL:
			return normal
		Globals.DAMAGE.FIRE:
			return fire
		Globals.DAMAGE.FROST:
			return frost
		Globals.DAMAGE.SHOCK:
			return shock
		Globals.DAMAGE.POISON:
			return poison
		_:
			return Color.WHITE
