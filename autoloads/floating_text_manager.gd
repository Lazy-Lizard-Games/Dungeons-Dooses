extends Node

@onready var root = get_tree().root
@onready var floating_damage = preload("res://scenes/ui/floating_damage/floating_damage.tscn")
@onready var floating_heal = preload("res://scenes/ui/floating_heal/heal_float.tscn")


func create_damage_float(position: Vector2, damage_data: DamageData) -> DamageFloat:
	var damage_float: DamageFloat = floating_damage.instantiate()
	damage_float.update(position, damage_data)
	return damage_float


func create_heal_float(position: Vector2, heal: int) -> HealFloat:
	var heal_float: HealFloat = floating_heal.instantiate()
	heal_float.position = position
	heal_float.heal = heal
	return heal_float
