extends Resource
class_name Effect

@export var icon: Image
@export var name: String = "Effect"
@export var stat_modifiers: Array[StatModifier] = []
@export var resist_modifiers: Array[ResistModifier] = []
@export var damage_modifiers: Array[DamageModifier] = []
