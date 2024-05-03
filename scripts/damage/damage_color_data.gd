extends Resource
class_name DamageColorData

@export var slash := Color.FIREBRICK
@export var pierce := Color.SILVER
@export var blunt := Color.LIGHT_STEEL_BLUE
@export var fire := Color.CORAL
@export var frost := Color.AQUAMARINE
@export var shock := Color.YELLOW
@export var poison := Color.DARK_MAGENTA
@export var light := Color.LIGHT_GOLDENROD

func getColorForType(type: Enums.DamageType) -> Color:
	match type:
		Enums.DamageType.Slash:
			return slash
		Enums.DamageType.Pierce:
			return pierce
		Enums.DamageType.Blunt:
			return blunt
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
