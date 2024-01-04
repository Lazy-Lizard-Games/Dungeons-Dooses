extends Node

var damage_text_scene = preload('res://resources/text/damage_text/damage_text.tscn')


func create_damage_text(type: Enums.DamageType, amount: float, position: Vector2, resist: bool = false, crit: bool = false) -> void:
	if !damage_text_scene:
		return
	
	var damage_text = damage_text_scene.instantiate() as DamageText
	damage_text.type = type
	damage_text.amount = amount
	damage_text.position = position
	if crit:
		pass
	if resist:
		pass
	add_child(damage_text)
