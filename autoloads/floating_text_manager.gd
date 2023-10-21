extends Node

@onready var root = get_tree().root
@onready var floating_damage = preload("res://scenes/ui/floating_damage/floating_damage.tscn")


func create_damage_float(position: Vector2, damage_data: DamageData) -> DamageFloat:
	var damage_float: DamageFloat = floating_damage.instantiate()
	damage_float.position = position
	damage_float.damage_data = damage_data
	return damage_float
