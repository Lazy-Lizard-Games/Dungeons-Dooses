extends Node2D


@export var slime_scene: PackedScene
@onready var delay_timer: Timer = $DelayTimer
var slime: Slime


func _ready() -> void:
	spawn_slime()


func spawn_slime() -> void:
	slime = slime_scene.instantiate()
	slime.health_component.died.connect(on_slime_died)
	add_child(slime)


func on_slime_died() -> void:
	slime = null
	delay_timer.start()


func _on_delay_timer_timeout() -> void:
	spawn_slime()
