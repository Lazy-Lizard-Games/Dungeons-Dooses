extends Node

var damage_text_scene = preload('res://resources/text/damage_text/damage_text.tscn')


func create_damage_text(damage: DamageData, position: Vector2, resist: bool = false, crit: bool = false) -> void:
	if !damage_text_scene:
		return
	
	var damage_text = damage_text_scene.instantiate() as DamageText
	damage_text.damage = damage
	damage_text.position = position
	add_child(damage_text)
