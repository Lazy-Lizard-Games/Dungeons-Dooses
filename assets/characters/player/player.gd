extends CharacterBody2D

@export var velocity_component: VelocityComponent

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
		velocity_component.accelerate_in_direction(direction)
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
	at["parameters/Attack/blend_position"] = attack_direction
	check_dash()

func dash() -> void:
	velocity_component.accelerate_in_direction(dash_direction*1.2)
	velocity_component.move(self)
# ------------------------------------------------------------------------------------------------ #

# State Advance Expressions ---------------------------------------------------------------------- #
# useful for states that are triggered once then return to previous state by
# providing much finer control over the condition leading to the state changing
# and allowing certain manipulation of script variables while you're at it
func check_attack_state() -> bool:
	await at.animation_finished
	state_manager.change_state(normal)
	at["parameters/conditions/is_attack"] = false
	return true

func check_dash_state() -> bool:
	await at.animation_finished
	state_manager.change_state(normal)
	at["parameters/conditions/is_dash"] = false
	direction = dash_direction
	return true
# ------------------------------------------------------------------------------------------------ #

# Input Checks ----------------------------------------------------------------------------------- #
func check_attack() -> void:
	if Input.is_action_just_pressed("primary"):
		at["parameters/conditions/is_attack"] = true
		attack_direction = transform.origin.direction_to(get_global_mouse_position())
		state_manager.change_state(attack)

func check_dash() -> void:
	if Input.is_action_just_pressed("dash"):
		at["parameters/conditions/is_dash"] = true
		at["parameters/conditions/is_attack"] = false
		dash_direction = direction if direction \
		 		else transform.origin.direction_to(get_global_mouse_position())
		state_manager.change_state(dash)
# ------------------------------------------------------------------------------------------------ #
