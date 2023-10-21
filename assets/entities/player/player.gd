extends CharacterBody2D
class_name Player

@export var faction: Globals.FACTIONS
@export var move_modifier: float = 1
@export var attack_speed_mult: float:
	get:
		return stats_component.attack_speed_mult if stats_component else attack_speed_mult
@export_range(0, 1) var dash_control: float = 0.05
@export_group("Components")
@export var velocity_component: VelocityComponent
@export var stats_component: StatsComponent
@export var hitbox_component: HitboxComponent
@export var weapon_component: WeaponComponent
@export var skill_component: SkillsComponent
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
	set_process_input(true)
	at.active = true
	state_manager.add_state(normal)
	state_manager.add_state(attack)
	state_manager.add_state(dash)
	state_manager.set_initial_state(normal)
	hitbox_component.faction = faction
# ------------------------------------------------------------------------------------------------ #

func _unhandled_input(event):
	if Input.is_action_just_pressed("holster"):
		#                                 #
		# REMEMBER TO REMOVE/CHANGE LATER #
		#                                 #
		skill_component.reset()

# Update handling -------------------------------------------------------------------------------- #
func _physics_process(_delta: float) -> void:
	$HealthComponent.current_health += 5
	
	direction = Vector2.ZERO
	if is_processing_input():
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
	check_dash()
	velocity_component.accelerate_in_direction(direction * move_modifier)
	velocity_component.move(self)

func dash() -> void:
	if direction:
		var control = dash_direction.angle_to(direction) * dash_control
		dash_direction = dash_direction.rotated(control).normalized()
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
	$CollisionShape2D.disabled = false
	return true
# ------------------------------------------------------------------------------------------------ #

# Action Input Checks ----------------------------------------------------------------------------------- #
func check_attack() -> void:
	if is_processing_input():
		if Input.is_action_pressed("primary"):
			set_attack(0)
		if Input.is_action_pressed("secondary"):
			set_attack(1)

func check_dash() -> void:
	if is_processing_input():
		if Input.is_action_just_pressed("dash"):
			set_dash()
# ------------------------------------------------------------------------------------------------ #

# Utility ---------------------------------------------------------------------------------------- #
func set_normal(condition: String, direction: Vector2) -> void:
	state_manager.change_state(normal)
	at[condition] = false
	at["parameters/Idle/blend_position"] = direction
	at["parameters/Walk/blend_position"] = direction
	move_modifier = 1.0

func set_attack(index) -> void:
	if weapon_component.attack(index):
		attack_direction = transform.origin.direction_to(get_global_mouse_position())
		at["parameters/conditions/is_attack"] = true
		at["parameters/Attack/BlendSpace/blend_position"] = attack_direction
		at["parameters/Attack/TimeScale/scale"] = attack_speed_mult
		state_manager.change_state(attack)
		move_modifier = weapon_component.move_modifier

func set_dash() -> void:
	$CollisionShape2D.disabled = true
	at["parameters/conditions/is_idle"] = true
	at["parameters/conditions/is_move"] = false
	at["parameters/conditions/is_dash"] = true
	at["parameters/conditions/is_attack"] = false
	at["parameters/Dash/blend_position"] = direction
	dash_direction = direction if direction \
	 		else transform.origin.direction_to(get_global_mouse_position())
	state_manager.change_state(dash)
	hitbox_component.detect_only = true
	move_modifier = 1.2
# ------------------------------------------------------------------------------------------------ #

# Animation Callables ---------------------------------------------------------------------------- #
func spawn_projectile() -> void:
	weapon_component.spawn_projectile(attack_direction, faction)
