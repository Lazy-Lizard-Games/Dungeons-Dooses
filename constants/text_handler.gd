extends Node

@onready var damage_text_scene = preload ('res://scenes/damage_text/damage_text.tscn')
@onready var damage_over_time_text_scene = preload ('res://scenes/damage_over_time_text/damage_over_time_text.tscn')
@onready var heal_text_scene = preload ('res://scenes/heal_text/heal_text.tscn')

func create_damage_text(damage_data: DamageData, position: Vector2) -> void:
	var damage_text = damage_text_scene.instantiate() as DamageText
	damage_text.amount = damage_data.amount
	damage_text.type = damage_data.type
	damage_text.position = position
	add_child(damage_text)

func create_damage_over_time_text(type: Enums.DamageType, amount: float, position: Vector2, resist: bool=false, crit: bool=false) -> void:
	var damage_over_time_text = damage_over_time_text_scene.instantiate() as DamageOverTimeText
	damage_over_time_text.type = type
	damage_over_time_text.amount = amount
	damage_over_time_text.position = position
	if crit:
		pass
	if resist:
		pass
	add_child(damage_over_time_text)

func create_heal_text(amount: float, position: Vector2) -> void:
	var heal_text = heal_text_scene.instantiate() as HealText
	heal_text.amount = amount
	heal_text.position = position
	add_child(heal_text)
