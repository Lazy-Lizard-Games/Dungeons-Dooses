extends CharacterBody2D


@export var move_modifier: float = 1.0
@export var faction: Globals.FACTIONS
@export_group("Components")
@export var velocity_component: VelocityComponent
@export var stats_component: StatsComponent
@export var hitbox_component: HitboxComponent
@export var hurtbox_component: HurtboxComponent

@onready var at: AnimationTree = $AnimationTree
@onready var state_manager: StateManager = StateManager.new()

var direction: Vector2 = Vector2.ZERO
var attack_direction: Vector2 = Vector2.ZERO
var knockback_direction: Vector2 = Vector2.ZERO

# Initialising ----------------------------------------------------------------------------------- #
func _ready() -> void:
	at.active = true
	state_manager.add_state(normal)
	state_manager.add_state(attack)
	state_manager.add_state(hurt)
	state_manager.add_state(death)
	state_manager.set_initial_state(normal)
	hitbox_component.faction = faction
	hurtbox_component.faction = faction
# ------------------------------------------------------------------------------------------------ #

# Update handling -------------------------------------------------------------------------------- #
func _physics_process(_delta: float) -> void:
	state_manager.update()
# ------------------------------------------------------------------------------------------------ #

# States ----------------------------------------------------------------------------------------- #
func normal() -> void:
	# Check target close enough to jump but not too close
	if direction:
		velocity_component.accelerate_in_direction(direction * move_modifier)
		velocity_component.move(self)
		at["parameters/conditions/is_idle"] = false
		at["parameters/conditions/is_move"] = true
		at["parameters/move/blend_position"] = direction.x
	else:
		velocity_component.decelerate()
		at["parameters/conditions/is_idle"] = true
		at["parameters/conditions/is_move"] = false

func attack() -> void:
	velocity_component.accelerate_in_direction(attack_direction * move_modifier)
	velocity_component.move(self)

func hurt() -> void:
	pass

func death() -> void:
	pass
# ------------------------------------------------------------------------------------------------ #

# Action Controls -------------------------------------------------------------------------------- #
func check_jump() -> bool:
	return false
# ------------------------------------------------------------------------------------------------ #

# State Advance Expressions ---------------------------------------------------------------------- #
func check_attack_state() -> bool:
	await at.animation_finished
	set_normal("parameters/conditions/is_attack", attack_direction)
	return true

func check_hurt_state() -> bool:
	await at.animation_finished
	set_normal("parameters/conditions/is_hurt", direction)
	return true

func check_death_state() -> bool:
	await at.animation_finished
	queue_free()
	return true
# ------------------------------------------------------------------------------------------------ #

# State Transitions ------------------------------------------------------------------------------ #
func set_normal(condition: String, dir: Vector2) -> void:
	at[condition] = false
	at["parameters/move/blend_position"] = dir.x
	state_manager.change_state(normal)

func set_attack() -> void:
	at["parameters/conditions/is_attack"] = true
	at["parameters/attack/blend_position"] = attack_direction.x
	state_manager.change_state(attack)

func set_hurt() -> void:
	at["parameters/conditions/is_hurt"] = true
	state_manager.change_state(hurt)

func set_death() -> void:
	$CollisionShape2D.disabled = true
	at["parameters/conditions/is_dead"] = true
	state_manager.change_state(death)
# ------------------------------------------------------------------------------------------------ #

# Signals ---------------------------------------------------------------------------------------- #
func _on_hitbox_component_hit_by_hurtbox(hurtbox: HurtboxComponent, damage: float) -> void:
	set_hurt()

func _on_timer_timeout() -> void:
	direction = Vector2.ZERO
	if randi() % 4 == 0:
		direction = Vector2.RIGHT.rotated(randf_range(0, 6.28319))

func _on_health_component_died() -> void:
	set_death()
# ------------------------------------------------------------------------------------------------ #
