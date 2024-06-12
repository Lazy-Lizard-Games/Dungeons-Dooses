extends Node2D

@export var breeze_time: float
@export var breeze_variance: float
@export var timer: Timer
@export var animation_player: AnimationPlayer

func start_timer() -> void:
	timer.start(breeze_time + randf_range(-breeze_variance, breeze_variance))

func _ready() -> void:
	start_timer()

func _on_timer_timeout() -> void:
	animation_player.play('breeze')

func _on_animation_player_animation_finished(_anim_name:StringName) -> void:
	animation_player.play('idle')
	start_timer()
