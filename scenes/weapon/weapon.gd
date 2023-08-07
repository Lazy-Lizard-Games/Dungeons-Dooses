extends Node2D

var title: String
var sprite: Sprite2D
var animator: AnimationPlayer
var damage_data: DamageData
var weapon_data: WeaponData
var primary_ability: AbilityData
var secondary_ability: AbilityData
var tertiary_ability: AbilityData
var current_ability = -1
var character: Character 

var primary_fire = false
var secondary_fire = false
var tertiary_fire = false

signal attack(move_penalty: float)
signal idle

func setup() -> void:
	sprite = $Sprite
	animator = $AnimationPlayer

func load_data(weapon: WeaponData, creator: Character) -> void:
	title = weapon.get_item_name()
	character = creator
	weapon_data = weapon
	damage_data = weapon.get_damage_data()
	sprite.texture = weapon.texture
	primary_ability = weapon.primary_ability
	secondary_ability = weapon.secondary_ability
	tertiary_ability = weapon.tertiary_ability
	load_animations()

func load_animations() -> void:
	if animator.has_animation_library("ability"):
		animator.remove_animation_library("ability")
	var anim_library = AnimationLibrary.new()
	if primary_ability:
		anim_library.add_animation("primary", primary_ability.animation)
	if secondary_ability:
		anim_library.add_animation("secondary", secondary_ability.animation)
	if tertiary_ability:
		anim_library.add_animation("tertiary", tertiary_ability.animation)
	animator.add_animation_library("ability", anim_library)

func _physics_process(_delta: float) -> void:
	if primary_fire and current_ability < 0:
		primary()
	
	if secondary_fire and current_ability < 0:
		secondary()
	
	if tertiary_fire and current_ability < 0:
		tertiary()

func primary() -> void:
	if primary_ability:
		current_ability = 0
		animator.play("ability/primary")

func secondary() -> void:
	if secondary_ability:
		current_ability = 1
		animator.play("ability/secondary")

func tertiary() -> void:
	if tertiary_ability:
		current_ability = 2
		animator.play("ability/tertiary")

func set_ability(index: int, ability: AbilityData) -> void:
	match index:
		0:
			weapon_data.primary_ability = ability
		1:
			weapon_data.secondary_ability = ability
		2:
			weapon_data.tertiary_ability = ability
	load_data(weapon_data, character)

func get_abilities() -> Array[AbilityData]:
	return [primary_ability, secondary_ability, tertiary_ability]

func get_type() -> Globals.WEAPON_TYPES:
	return weapon_data.weapon_type

func spawn_projectile() -> void:
	var projectile: Projectile = get_ability().create_projectile()
	if projectile:
		# Modify damage with character stats and projectile stats
		var damage = damage_data.copy()
		damage.mod_stats(character.get_damage_stats())
		projectile.mod_damage_data(damage)
		add_child(projectile)
	# Possibility of projectiles being deleted when weapon is deleted
	# Solution could be to spawn projectiles as a child of the map instead

func get_ability() -> AbilityData:
	var ability = null
	match current_ability:
		0:
			ability = primary_ability
		1:
			ability = secondary_ability
		2:
			ability = tertiary_ability
		_:
			print("Not Attacking")
	return ability

func get_item_name() -> String:
	return weapon_data.get_item_name()

func end_actions() -> void:
	primary_fire = false
	secondary_fire = false
	tertiary_fire = false
	animator.play("RESET")
	emit_idle()

func emit_attacking() -> void:
	attack.emit(get_ability().get_move_penalty())

func emit_idle() -> void:
	animator.stop()
	current_ability = -1
	idle.emit()

func on_primary_down() -> void:
	primary_fire = true

func on_primary_up() -> void:
	primary_fire = false

func on_secondary_down() -> void:
	secondary_fire = true

func on_secondary_up() -> void:
	secondary_fire = false

func on_tertiary_down() -> void:
	tertiary_fire = true

func on_tertiary_up() -> void:
	tertiary_fire = false
