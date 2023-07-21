extends Node2D

var sprite: Sprite2D
var animator: AnimationPlayer
var damage_data: DamageData
var primary_attack: AttackData = null
var secondary_attack: AttackData = null
var current_attack = -1
var character: Character 

var primary_fire = false
var secondary_fire = false

signal attack
signal idle

func setup() -> void:
	sprite = $Sprite
	animator = $AnimationPlayer

func load_data(weapon_data: WeaponData, creator: Character) -> void:
	character = creator
	damage_data = weapon_data.get_damage()
	sprite.texture = weapon_data.texture
	primary_attack = weapon_data.primary_attack
	secondary_attack = weapon_data.secondary_attack
	load_animations()

func load_animations() -> void:
	var anim_library = AnimationLibrary.new()
	if primary_attack:
		anim_library.add_animation("primary", primary_attack.animation)
	if secondary_attack:
		anim_library.add_animation("secondary", secondary_attack.animation)
	animator.add_animation_library("attacks", anim_library)

func _physics_process(delta: float) -> void:
	if primary_fire and current_attack < 0:
		primary()
	
	if secondary_fire and current_attack < 0:
		secondary()

func primary() -> void:
	if primary_attack:
		current_attack = 0
		animator.play("attacks/primary")

func secondary() -> void:
	if secondary_attack:
		current_attack = 1
		animator.play("attacks/secondary")

func spawn_projectile() -> void:
	var attack = get_attack()
	var projectile = attack.projectile.instantiate()
	var damage = damage_data.copy()
	damage.mod_damage(character.get_damage_mult(damage.get_type()))
	projectile.set_damage(damage)
	add_child(projectile)
	# Possibility of projectiles being deleted when weapon is deleted
	# Solution could be to spawn projectiles as a child of the map instead

func get_attack() -> AttackData:
	var attack = null
	match current_attack:
		0:
			attack = primary_attack
		1:
			attack = secondary_attack
		_:
			print("Not Attacking")
	return attack

func emit_attacking() -> void:
	attack.emit()

func emit_idle() -> void:
	current_attack = -1
	idle.emit()

func on_primary_down() -> void:
	primary_fire = true

func on_primary_up() -> void:
	primary_fire = false

func on_secondary_down() -> void:
	secondary_fire = true

func on_secondary_up() -> void:
	secondary_fire = false
