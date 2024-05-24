extends Ability

## The snipe ability provides the warrior a high damage, long range attack.

const DAMAGE_TYPE = Enums.DamageType.Pierce

@export var player: Player
@export var idle_state: State
@export var animation_player: AnimationPlayer
@export var sprite: Sprite2D
@export var damage: float
@export var effect: PiercedEffect
@export var knockback: float
@export var snipe_projectile: PackedScene
@export var raycast: RayCast2D
@export var line: Line2D

var has_charged := false
var has_fired := false
var angle: float = 0

func _ready():
	raycast.add_exception(player.hitbox_component)

func enter() -> void:
	line.points[1].x = 0
	line.visible = true
	animation_player.play("snipe_charge_side")
	cast()

func exit() -> void:
	has_charged = false
	has_fired = false
	refresh()

func process_frame(_delta: float) -> State:
	if Input.is_action_just_released("ability_2"):
		if has_charged:
			if !has_fired:
				fire_projectile()
		else:
			return idle_state
	return null

func process_physics(_delta: float) -> State:
	var current_position = animation_player.current_animation_position
	if !has_fired:
		angle = player.looking_at.angle()
		update_animation('snipe_charge', current_position)
	else:
		if current_position >= animation_player.current_animation_length:
			return idle_state
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	player.velocity_component.accelerate_in_direction(direction * 0.1)
	player.velocity_component.move(player)
	if !has_fired:
		raycast.position = player.centre_position
		raycast.look_at(player.get_global_mouse_position())
		line.global_position = player.centre_position
		line.look_at(player.get_global_mouse_position())
		var collider = raycast.get_collider()
		if (collider and collider is HitboxComponent and casting_timer / casting_time > 0.1):
			line.points[1].x = player.centre_position.distance_to(collider.global_position)
		else:
			line.points[1].x = 150 * (casting_timer / casting_time)
	return null

func update_animation(base: String, position: float) -> void:
	sprite.flip_h = player.looking_at.x < 0
	if angle >= 2.75 or angle < - 2.75:
		animation_player.play(base + '_side') # left
	elif angle >= - 2.75 and angle < - 1.96:
		animation_player.play(base + '_up_side') # top-left
	elif angle >= - 1.96 and angle < - 1.18:
		animation_player.play(base + '_up') # top
	elif angle >= - 1.18 and angle < - 0.39:
		animation_player.play(base + '_up_side') # top-right
	elif angle >= - 0.39 and angle < 0.39:
		animation_player.play(base + '_side') # right
	elif angle >= 0.39 and angle < 1.18:
		animation_player.play(base + '_down_side') # bottom-right
	elif angle >= 1.18 and angle < 1.96:
		animation_player.play(base + '_down') # bottom
	else:
		animation_player.play(base + '_down_side') # bottom-right
	animation_player.seek(position)

func get_target_position() -> Vector2:
	var target_position: Vector2
	while !target_position:
		raycast.force_raycast_update()
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider is HitboxComponent:
				if collider.faction != player.faction or collider.faction == Enums.FactionType.None:
					target_position = raycast.get_collision_point()
				else:
					raycast.add_exception(collider)
			elif collider is StaticBody2D:
				target_position = raycast.get_collision_point()
			else:
				raycast.add_exception(collider)
		else:
			target_position = (raycast.position + raycast.target_position).rotated(raycast.rotation)
	return target_position

func fire_projectile() -> void:
	line.visible = false
	has_charged = false
	has_fired = true
	update_animation('snipe_fire', 0)
	player.stamina_component.exhaust(cost * player.stats_component.ability_efficiency.get_final_value())
	var affinity = player.stats_component.get_final_affinity_for(DAMAGE_TYPE)
	var damage_data = DamageData.new(damage * affinity, DAMAGE_TYPE)
	var effect_data = EffectData.new(effect, 1)
	var impact_data = ImpactData.new([damage_data], knockback, [effect_data])
	var target_position = get_target_position()
	var projectile: Projectile = snipe_projectile.instantiate()
	projectile.init(target_position, player.looking_at, impact_data, player.faction, false)
	ProjectileHandler.add_projectile(projectile)

func _on_casted():
	has_charged = true
