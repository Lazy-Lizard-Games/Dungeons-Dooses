extends Node

@onready var root = get_tree().root
@onready var damage_float_scene = preload("res://scenes/ui/floating_damage/floating_damage.tscn")


func create_damage_float(position: Vector2, damage_data: DamageData) -> DamageFloat:
	var damage_float = damage_float_scene.instantiate()
	damage_float.init(damage_data.type, damage_data.damage, 1)
	damage_float.position = position
	return damage_float
