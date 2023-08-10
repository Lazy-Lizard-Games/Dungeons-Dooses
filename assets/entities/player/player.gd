extends CharacterBody2D

@export var move_modifier: float = 1
@export_range(0, 1) var dash_control: float = 0.05
@export_group("Components")
@export var velocity_component: VelocityComponent
@export var hitbox_component: HitboxComponent
@export var weapon_component: WeaponComponent
@export_group("Animation Resource Paths")
@export_file var attack_left
@export_file var attack_right
@export_file var attack_up
@export_file var attack_down

@onready var at: AnimationTree = $AnimationTree
@onready var state_manager: StateManager = StateManager.new()

var direction: Vector2 = Vector2.ZERO
var dash_direction: Vector2 = Vector2.ZERO
var attack_direction: Vector2 = Vector2.ZERO

# Initialising ----------------------------------------------------------------------------------- #
func _ready() -> void:
	at.active = true
	state_manager.add_state(normal)
	state_manager.add_state(attack)
	state_manager.add_state(dash)
	state_manager.set_initial_state(normal)
# ------------------------------------------------------------------------------------------------ #

# Update handling -------------------------------------------------------------------------------- #
func _physics_process(_delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	state_manager.update()
# ------------------------------------------------------------------------------------------------ #

# States ----------------------------------------------------------------------------------------- #
func normal() -> void:
	check_attack()
	check_dash()
	
	if direction:
		velocity_component.accelerate_in_direction(direction * move_modifier)
		velocity_component.move(self)
		at["parameters/conditions/is_idle"] = false
		at["parameters/conditions/is_move"] = true
		at["parameters/Idle/blend_position"] = direction
		at["parameters/Walk/blend_position"] = direction
	else:
		velocity_component.decelerate()
		at["parameters/conditions/is_idle"] = true
		at["parameters/conditions/is_move"] = false

func attack() -> void:
	velocity_component.accelerate_in_direction(direction * move_modifier)
	velocity_component.move(self)
	check_dash()

func dash() -> void:
	if direction:
		var control = dash_direction.angle_to(direction)*dash_control
		dash_direction = dash_direction.rotated(control)
	direction = dash_direction
	velocity_component.accelerate_in_direction(direction * move_modifier)
	velocity_component.move(self)
# ------------------------------------------------------------------------------------------------ #

# State Advance Expressions ---------------------------------------------------------------------- #
# useful for states that are triggered once then return to previous state by
# providing much finer control over the condition leading to the state changing
# and allowing certain manipulation of script variables while you're at it
func check_attack_state() -> bool:
	await at.animation_finished
	set_normal("parameters/conditions/is_attack", attack_direction)
	return true

func check_dash_state() -> bool:
	await at.animation_finished
	set_normal("parameters/conditions/is_dash", dash_direction)
	hitbox_component.detect_only = false
	return true
# ------------------------------------------------------------------------------------------------ #

# Input Checks ----------------------------------------------------------------------------------- #
func check_attack() -> void:
	if Input.is_action_just_pressed("primary"):
		set_attack(0)
	
	if Input.is_action_just_pressed("secondary"):
		set_attack(1)
	
	if Input.is_action_just_pressed("tertiary"):
		set_attack(2)

func check_dash() -> void:
	if Input.is_action_just_pressed("dash"):
		at["parameters/conditions/is_dash"] = true
		at["parameters/conditions/is_attack"] = false
		at["parameters/Dash/blend_position"] = direction
		dash_direction = direction if direction \
		 		else transform.origin.direction_to(get_global_mouse_position())
		state_manager.change_state(dash)
		hitbox_component.detect_only = true
		move_modifier = 1.2
# ------------------------------------------------------------------------------------------------ #

# Utility ---------------------------------------------------------------------------------------- #
func set_attack(index) -> void:
	if weapon_component.attack(index):
		at["parameters/conditions/is_attack"] = true
		at["parameters/Attack/blend_position"] = attack_direction
		attack_direction = transform.origin.direction_to(get_global_mouse_position())
		state_manager.change_state(attack)
		move_modifier = weapon_component.move_modifier

func set_normal(condition: String, direction: Vector2) -> void:
	state_manager.change_state(normal)
	at[condition] = false
	at["parameters/Idle/blend_position"] = dash_direction
	at["parameters/Walk/blend_position"] = dash_direction
	move_modifier = 1.0
# ------------------------------------------------------------------------------------------------ #

# Animation Callables ---------------------------------------------------------------------------- #
func spawn_projectile() -> void:
	weapon_component.spawn_projectile(attack_direction)
