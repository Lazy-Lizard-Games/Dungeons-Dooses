extends Resource
class_name DamageColorData

@export var normal := Color.GRAY
@export var fire := Color.RED
@export var frost := Color.BLUE
@export var shock := Color.YELLOW
@export var poison := Color.GREEN
@export var light := Color.BEIGE

func getColorForType(type: Enums.DamageType) -> Color:
	match type:
		Enums.DamageType.Slash:
			return normal
		Enums.DamageType.Fire:
			return fire
		Enums.DamageType.Frost:
			return frost
		Enums.DamageType.Shock:
			return shock
		Enums.DamageType.Poison:
			return poison
		Enums.DamageType.True:
			return light
		_:
			return Color.WHITE
