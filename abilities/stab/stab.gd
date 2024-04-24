extends Ability

## Thrusts the sword forward, piercing hit enemies and reduces their physical resistance.

## The projectile that will be created when the ability is casted.
@export var stab_projectile_scene: PackedScene
## The time in seconds it takes to charge the ability.
@export var charge_time: float
## The time in seconds it takes to charge the ability.
@export var recharge_time: float
## State to move to when ability is casted.
@export var idle_state: State
## Animation tree which will play the animation.
@export var animation_tree: AnimationTree
## Velocity component which will update movement from inputs.
@export var velocity: VelocityComponent

var is_finished := false
var direction := Vector2.ZERO
var charge_timer: Timer
var recharge_timer: Timer

func _ready():
	charge_timer = Timer.new()
	charge_timer.one_shot = true
	charge_timer.timeout.connect(_on_charge_timer_timeout)
	add_child(charge_timer)
	recharge_timer = Timer.new()
	recharge_timer.one_shot = true
	recharge_timer.timeout.connect(_on_recharge_timer_timeout)
	add_child(recharge_timer)

func process_physics(_delta: float) -> State:
	if is_finished:
		return idle_state
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity.accelerate_in_direction(direction * 0.1)
	velocity.move(entity)
	return null

func enter() -> void:
	animation_tree['parameters/playback'].travel('stab')
	animation_tree['parameters/stab/blend_position'] = entity.global_position.direction_to(entity.get_global_mouse_position())
	animation_tree.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)
	start()

func exit() -> void:
	is_finished = false
	end()

func _on_animation_finished(_animation) -> void:
	cast()

func _on_charge_timer_timeout():
	charge()
	
func _on_recharge_timer_timeout():
	recharge()

func _on_started():
	charge_timer.start(charge_time * entity.generics.get_generic(Enums.GenericType.AbilityCast).get_final_value())

func _on_charged():
	var exhaust = ExhaustEntityAction.new(cost.get_number() * entity.generics.get_generic(Enums.GenericType.AbilityEfficiency).get_final_value())
	exhaust.execute(entity)
	var stab_projectile: Projectile = stab_projectile_scene.instantiate()
	stab_projectile.init(entity, entity.global_position, entity.global_position.direction_to(entity.get_global_mouse_position()))
	ProjectileHandler.add_projectile(stab_projectile)

func _on_casted():
	recharge_timer.start(recharge_time * entity.generics.get_generic(Enums.GenericType.AbilityCooldown).get_final_value())
	is_finished = true

func _on_recharged():
	print('Recharged!')
