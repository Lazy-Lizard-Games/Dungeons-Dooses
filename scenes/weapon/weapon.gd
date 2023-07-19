extends Node2D

var sprite: Sprite2D
var animator: AnimationPlayer
var primary_attack: AttackData
var secondary_attack: AttackData

signal attack
signal idle



func setup() -> void:
	sprite = $Sprite
	animator = $AnimationPlayer

func load_data(weapon_data: WeaponData) -> void:
	sprite.texture = weapon_data.texture
	primary_attack = weapon_data.primary_attack
	secondary_attack = weapon_data.secondary_attack
	var anim_library = AnimationLibrary.new()
	anim_library.add_animation("primary", primary_attack.animation)
	anim_library.add_animation("secondary", secondary_attack.animation)
	animator.add_animation_library("attacks", anim_library)

func primary() -> void:
	animator.play("attacks/primary")

func secondary() -> void:
	animator.play("attacks/secondary")

func emit_attacking() -> void:
	attack.emit()

func emit_idle() -> void:
	idle.emit()
