extends Node2D

var sprite: Sprite2D
var animator: AnimationPlayer
var primary_attack: AttackData
var secondary_attack: AttackData
var current_attack = -1

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
	current_attack = 0
	animator.play("attacks/primary")

func secondary() -> void:
	current_attack = 1
	animator.play("attacks/secondary")

func spawn_projectile() -> void:
	var projectile = get_projectile().instantiate()
	add_child(projectile)

func get_projectile() -> PackedScene:
	var projectile = null
	match current_attack:
		0:
			projectile = primary_attack.projectile
		1:
			projectile = secondary_attack.projectile
		_:
			print("Not Attacking")
	return projectile

func emit_attacking() -> void:
	attack.emit()

func emit_idle() -> void:
	current_attack = -1
	idle.emit()

func on_primary_down() -> void:
	pass

func on_primary_up() -> void:
	pass

func on_secondary_down() -> void:
	pass

func on_secondary_up() -> void:
	pass
