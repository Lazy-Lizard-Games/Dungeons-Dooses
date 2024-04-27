extends Ability

## Sweeps the sword in frnot of you, cleaving all those foolish enough to stand too close.

## The damage dealt by this ability.
@export var damage: DamageData
## The knockback applied by this ability.
@export var knockback: float
## The projectile that will be created when the ability is casted.
@export var strike_projectile_scene: PackedScene
## The time in seconds it takes to charge the ability.
## State to move to when ability is casted.
@export var idle_state: State
## Animation tree which will play the animation.
@export var animation_tree: AnimationTree
## Velocity component which will update movement from inputs.
@export var velocity: VelocityComponent
## The stamina component to exhaust when the ability is cast.
@export var stamina_component: StaminaComponent

var is_finished := false
var direction := Vector2.ZERO

func enter() -> void:
	animation_tree['parameters/playback'].travel('strike')
	animation_tree['parameters/strike/blend_position'] = entity.looking_at
	animation_tree.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)
	cast()

func process_physics(_delta: float) -> State:
	if is_finished:
		return idle_state
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity.accelerate_in_direction(direction * 0.1)
	velocity.move(entity)
	return null

func exit() -> void:
	is_finished = false
	refresh()

func _on_animation_finished(_animation) -> void:
	is_finished = true

func _on_casted():
	if stamina_component:
		stamina_component.exhaust(cost * entity.generics.ability_efficiency.get_final_value())
	var impact_data = ImpactData.new([damage], knockback, [])
	var strike_projectile: Projectile = strike_projectile_scene.instantiate()
	strike_projectile.init(entity.centre_position, entity.looking_at, impact_data)
	ProjectileHandler.add_projectile(strike_projectile)

func _on_refreshed():
	ready()
