extends Area2D

@export var animation_player: AnimationPlayer

func _on_body_entered(body:Node2D) -> void:
	if body is Mob:
		animation_player.play('breeze')

func _on_animation_player_animation_finished(_anim_name:StringName) -> void:
	animation_player.play('idle')
