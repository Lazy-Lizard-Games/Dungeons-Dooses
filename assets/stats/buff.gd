extends Resource
class_name Buff

@export var icon: Image
@export var name: String = "Buff"
@export var stat_modifiers: Array[StatModifier] = []
@export var resist_modifiers: Array[ResistModifier] = []
@export var damage_modifiers: Array[DamageModifier] = []
