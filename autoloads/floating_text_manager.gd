extends Node

@onready var root = get_tree().root
@onready var floating_damage = preload("res://scenes/ui/floating_damage.tscn")

func create_damage_float(position: Vector2, damage: float) -> DamageFloat:
	var damage_float = floating_damage.instantiate()
	damage_float.update(position, damage)
	return damage_float
