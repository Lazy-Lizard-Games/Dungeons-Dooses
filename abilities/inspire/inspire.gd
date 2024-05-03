extends Ability

## Channel your inner commander and inspire all nearby allies with increased attack and defence.

## The player using/affected by this ability.
@export var player: Player
## The inspire effect which will be applied by the projectile.
@export var inspire_effect: InspireEffect
## The projectile which will be used to deliver the effect.
@export var projectile_scene: PackedScene
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
	animation_tree['parameters/playback'].travel('inspire')
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
	var impact_data = ImpactData.new([], 0, [inspire_effect])
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.init(player.centre_position, player.looking_at, impact_data, player.faction, true)
	ProjectileHandler.add_projectile(projectile)

func _on_refreshed():
	ready()
