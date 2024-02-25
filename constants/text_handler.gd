extends Node

@onready var damage_text_scene = preload('res://resources/text/damage_text/damage_text.tscn')
@onready var heal_text_scene = preload('res://resources/text/heal_text/heal_text.tscn')


func create_damage_text(type: Enums.DamageType, amount: float, position: Vector2, resist: bool = false, crit: bool = false) -> void:
	var damage_text = damage_text_scene.instantiate() as DamageText
	damage_text.type = type
	damage_text.amount = amount
	damage_text.position = position
	if crit:
		pass
	if resist:
		pass
	add_child(damage_text)


func create_heal_text(amount: float, position: Vector2) -> void:
	var heal_text = heal_text_scene.instantiate() as HealText
	heal_text.amount = amount
	heal_text.position = position
	add_child(heal_text)
