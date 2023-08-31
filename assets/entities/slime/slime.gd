extends CharacterBody2D


@export var move_modifier: float = 1.0
@export var lunge_range: int = 50
@export var faction: Globals.FACTIONS
@export_group("Components")
@export var velocity_component: VelocityComponent
@export var stats_component: StatsComponent
@export var hitbox_component: HitboxComponent
@export var hurtbox_component: HurtboxComponent
@export var tracker_component: TrackerComponent

@onready var at: AnimationTree = $AnimationTree
@onready var state_manager: StateManager = StateManager.new()

var direction: Vector2 = Vector2.ZERO
var attack_direction: Vector2 = Vector2.ZERO
var knockback_direction: Vector2 = Vector2.ZERO

# Initialising ----------------------------------------------------------------------------------- #
func _ready() -> void:
	at.active = true
	state_manager.add_state(normal)
	state_manager.add_state(hunt)
	state_manager.add_state(attack)
	state_manager.add_state(hurt)
	state_manager.add_state(death)
	state_manager.set_initial_state(normal)
	hitbox_component.faction = faction
	hurtbox_component.faction = faction
	tracker_component.faction = faction
# ------------------------------------------------------------------------------------------------ #

# Update handling -------------------------------------------------------------------------------- #
func _physics_process(_delta: float) -> void:
	state_manager.update()
	#print("%s - %s" % [state_manager.current_state, move_modifier])

func update_attack_direction() -> void:
	attack_direction = global_position.direction_to(tracker_component.target.global_position)
# ------------------------------------------------------------------------------------------------ #

# States ----------------------------------------------------------------------------------------- #
func normal() -> void:
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

func hunt() -> void:
	direction = global_position.direction_to(tracker_component.target.global_position)
	if can_lunge():
		set_attack(direction)
	velocity_component.accelerate_in_direction(direction * move_modifier)
	velocity_component.move(self)
	at["parameters/move/blend_position"] = direction.x

func attack() -> void:
	velocity_component.accelerate_in_direction(attack_direction * move_modifier)
	velocity_component.move(self)

func hurt() -> void:
	pass

func death() -> void:
	pass
# ------------------------------------------------------------------------------------------------ #

# Action Controls -------------------------------------------------------------------------------- #
func can_lunge() -> bool:
	if global_position.distance_to(tracker_component.target.global_position) < lunge_range \
			and $LungeCooldown.is_stopped():
		return true
	return false
# ------------------------------------------------------------------------------------------------ #

# State Advance Expressions ---------------------------------------------------------------------- #
func check_attack_state() -> bool:
	await at.animation_finished
	$LungeCooldown.start()
	at["parameters/conditions/is_attack"] = false
	if tracker_component.target:
		set_hunt()
	else:
		set_normal()
	return true

func check_hurt_state() -> bool:
	await at.animation_finished
	at["parameters/conditions/is_hurt"] = false
	set_normal()
	return true

func check_death_state() -> bool:
	await at.animation_finished
	queue_free()
	return true
# ------------------------------------------------------------------------------------------------ #

# State Transitions ------------------------------------------------------------------------------ #
func set_normal() -> void:
	at["parameters/move/blend_position"] = direction.x
	state_manager.change_state(normal)

func set_hunt() -> void:
	at["parameters/conditions/is_idle"] = false
	at["parameters/conditions/is_move"] = true
	state_manager.change_state(hunt)

func set_attack(dir: Vector2) -> void:
	attack_direction = dir
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


func _on_tracker_component_target_updated(target) -> void:
	if target:
		set_hunt()
	else:
		state_manager.change_state(normal)
# ------------------------------------------------------------------------------------------------ #
