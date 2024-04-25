extends Ability

## Sweeps the sword in frnot of you, cleaving all those foolish enough to stand too close.

## The projectile that will be created when the ability is casted.
@export var strike_projectile_scene: PackedScene
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
	animation_tree['parameters/playback'].travel('strike')
	animation_tree['parameters/strike/blend_position'] = entity.looking_at
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
	charge_timer.start(charge_time * entity.generics.ability_cast.get_final_value())

func _on_charged():
	var exhaust = ExhaustEntityAction.new(cost.get_number() * entity.generics.ability_efficiency.get_final_value())
	exhaust.execute(entity)
	var strike_projectile: Projectile = strike_projectile_scene.instantiate()
	strike_projectile.init(entity, entity.centre_position, entity.looking_at)
	ProjectileHandler.add_projectile(strike_projectile)

func _on_casted():
	recharge_timer.start(recharge_time * entity.generics.ability_cooldown.get_final_value())
	is_finished = true
