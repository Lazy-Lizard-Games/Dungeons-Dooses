extends Ability

## The snipe ability provides the warrior a high damage, long range attack.

const DAMAGE_TYPE = Enums.DamageType.Pierce

@export var damage: float
@export var knockback: float
@export var snipe_projectile: PackedScene
@export var raycast: RayCast2D
@export var line: Line2D

var has_charged := false
var has_fired := false
var angle: float = 0

func init(ability: AbilityComponent) -> void:
	super(ability)
	raycast.add_exception(mob.hitbox_component)

func enter() -> void:
	line.points[1].x = 0
	line.visible = true
	mob.animation_player.play("snipe_charge_side")
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
			return mob.state_component.starting_state
	return null

func process_physics(_delta: float) -> State:
	var current_position = mob.animation_player.current_animation_position
	if !has_fired:
		angle = mob.looking_at.angle()
		update_animation('snipe_charge', current_position)
	else:
		if current_position >= mob.animation_player.current_animation_length:
			return mob.state_component.starting_state
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	mob.velocity_component.accelerate_in_direction(direction * 0.1)
	mob.velocity_component.move(mob)
	if !has_fired:
		raycast.position = mob.centre_position
		raycast.look_at(mob.get_global_mouse_position())
		line.global_position = mob.centre_position
		line.look_at(mob.get_global_mouse_position())
		var collider = raycast.get_collider()
		if (collider and collider is HitboxComponent and casting_timer / casting_time > 0.1):
			line.points[1].x = mob.centre_position.distance_to(collider.global_position)
		else:
			line.points[1].x = 150 * (casting_timer / casting_time)
	return null

func update_animation(base: String, position: float) -> void:
	mob.sprite.flip_h = mob.looking_at.x < 0
	if angle >= 2.75 or angle < - 2.75:
		mob.animation_player.play(base + '_side') # left
	elif angle >= - 2.75 and angle < - 1.96:
		mob.animation_player.play(base + '_up_side') # top-left
	elif angle >= - 1.96 and angle < - 1.18:
		mob.animation_player.play(base + '_up') # top
	elif angle >= - 1.18 and angle < - 0.39:
		mob.animation_player.play(base + '_up_side') # top-right
	elif angle >= - 0.39 and angle < 0.39:
		mob.animation_player.play(base + '_side') # right
	elif angle >= 0.39 and angle < 1.18:
		mob.animation_player.play(base + '_down_side') # bottom-right
	elif angle >= 1.18 and angle < 1.96:
		mob.animation_player.play(base + '_down') # bottom
	else:
		mob.animation_player.play(base + '_down_side') # bottom-right
	mob.animation_player.seek(position)

func get_target_position() -> Vector2:
	var target_position: Vector2
	while !target_position:
		raycast.force_raycast_update()
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider is HitboxComponent:
				if collider.faction != mob.faction or collider.faction == Enums.FactionType.None:
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
	mob.stamina_component.exhaust(cost * mob.stats_component.ability_efficiency.get_final_value())
	var affinity = mob.stats_component.get_final_affinity_for(DAMAGE_TYPE)
	var damage_data = DamageData.new(damage * affinity, DAMAGE_TYPE)
	var impact_data = ImpactData.new([damage_data], knockback, [])
	var target_position = get_target_position()
	var projectile: Projectile = snipe_projectile.instantiate()
	projectile.init(target_position, mob.looking_at, impact_data, mob.faction, false)
	ProjectileHandler.add_projectile(projectile)

func _on_casted():
	has_charged = true

func _on_started() -> void:
	mob.state_component.change_state(self)