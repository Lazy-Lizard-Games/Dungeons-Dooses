extends Resource
class_name DamageColorData

@export var normal := Color.GRAY
@export var fire := Color.RED
@export var frost := Color.BLUE
@export var shock := Color.YELLOW
@export var poison := Color.GREEN


func getColorForType(type: Enums.DamageType) -> Color:
	match type:
		Enums.DamageType.Normal:
			return normal
		Enums.DamageType.Fire:
			return fire
		Enums.DamageType.Frost:
			return frost
		Enums.DamageType.Shock:
			return shock
		Enums.DamageType.Poison:
			return poison
		_:
			return Color.WHITE
