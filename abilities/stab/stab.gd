extends Ability

## Thrusts the sword forward, piercing hit enemies and reduces their physical resistance.

@export var player: Player
## The damage dealt by this ability.
@export var damage: DamageData
## The knockback applied by this ability.
@export var knockback: float
## The effect dealt by the ability. TODO: change
@export var burning_effect: BurningEffect
## The projectile that will be created when the ability is casted.
@export var stab_projectile_scene: PackedScene
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

var cost_modifier: float:
	get:
		if stats_component:
			return stats_component.ability_efficiency.get_final_value()
		return 1

func enter() -> void:
	animation_tree['parameters/playback'].travel('stab')
	animation_tree['parameters/stab/blend_position'] = player.looking_at
	animation_tree.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)
	cast()

func process_physics(_delta: float) -> State:
	if is_finished:
		return idle_state
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity.accelerate_in_direction(direction * 0.1)
	velocity.move(player)
	return null

func exit() -> void:
	is_finished = false
	refresh()

func _on_animation_finished(_animation) -> void:
	is_finished = true

func _on_casted():
	if stamina_component:
		stamina_component.exhaust(cost * cost_modifier)
	var affinity = stats_component.get_damage_affinity(damage.type)
	var impact_data = ImpactData.new([DamageData.new(damage.amount * (1 + affinity.get_final_value()), damage.type)], knockback, [])
	var stab_projectile: Projectile = stab_projectile_scene.instantiate()
	stab_projectile.init(player.centre_position, player.looking_at, impact_data, player.faction, false)
	ProjectileHandler.add_projectile(stab_projectile)

func _on_refreshed():
	ready()
