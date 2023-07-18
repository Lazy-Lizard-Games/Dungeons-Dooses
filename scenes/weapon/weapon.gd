extends Node2D

var sprite: Sprite2D
var animator: AnimationPlayer

signal attack
signal idle

func setup() -> void:
	sprite = $Sprite
	animator = $AnimationPlayer

func load_data(weapon_data: WeaponData) -> void:
	sprite.texture = weapon_data.texture

func primary() -> void:
	print("Main attack")
	animator.play("primary")

func secondary() -> void:
	print("Special attack")

func emit_attacking() -> void:
	attack.emit()

func emit_idle() -> void:
	idle.emit()
