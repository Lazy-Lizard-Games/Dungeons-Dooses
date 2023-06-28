extends ItemData
class_name ArmourData

@export var defence = 10
@export var armour_type: Globals.ARMOUR_TYPES
@export var damage_modifiers: Array[DamageModifier]
@export var resist_modifiers: Array[ResistModifier]
@export var stat_modifiers: Array[StatModifier]

func setup() -> void:
	item_type = Globals.ITEM_TYPES.ARMOUR
