extends CharacterBody2D
class_name BaseProjectile

## Projectiles are spawned by entities and allow for hit/hurt triggers at range.

## Render component of the projectile.
@export var render_component: RenderComponent
## Hurtbox responsible for triggering hits.
@export var hurtbox_component: HurtboxComponent
## Collision shape of the projectile.
@export var collision_shape: CollisionShape2D
## Collision shape of the hurtbox.
@export var hurtbox_collision_shape: CollisionShape2D
## Identifying name of the projectile.
var id: String
## Pierce maximum of the projectile, where anything less than zero results in infinite pierce.
var pierce: int
## Duration of the projectile, where anything less than zero results in infinite duration.
var duration: Number
## Direction of the projectile.
var direction: Vector
## Actions to execute on hurt.
var actions_on_hurt: Array[BientityAction]
## Entity responsible for spawning the projectile, if any.
var entity: Entity
## Current pierce of the projectile.
var current_pierce: int
## Current direction of the projectile.
var _direction: Vector2
## Inverts faction check, hitting allies instead of enemies.
var target_allies: bool

## Is the projectile expired.
var is_expired: bool:
	get:
		return current_pierce <= 0 and pierce > 0


func set_variables(projectile_object: BaseProjectileObject) -> void:
	id = projectile_object.name
	pierce = projectile_object.pierce
	duration = projectile_object.duration
	direction = projectile_object.direction
	actions_on_hurt = projectile_object.actions_on_hurt
	target_allies = projectile_object.target_allies
	collision_shape.shape = projectile_object.shape
	collision_shape.position = projectile_object.shape_offset
	hurtbox_collision_shape.shape = projectile_object.shape
	hurtbox_collision_shape.position = projectile_object.shape_offset
	hurtbox_component.single_hit = projectile_object.single_hit
	render_component.sprite_frames = projectile_object.sprite_frames
	self.scale = Vector2.ONE * projectile_object.scale.execute()
	z_index = projectile_object.z_index_offset


func _ready() -> void:
	z_index += 1
	render_component.frame_progress = 0
	if 'default' in render_component.sprite_frames.get_animation_names():
		render_component.play('default')
	_direction = direction.get_vector(entity)
	look_at(global_position + _direction)
	current_pierce = pierce
	hurtbox_component.hurt.connect(on_hurt)
	var _duration = duration.execute()
	if _duration > 0:
		var duration_timer = Timer.new()
		duration_timer.timeout.connect(
			func():
				ProjectileHandler.remove_projectile(self)
		)
		add_child(duration_timer)
		duration_timer.start(_duration)


func on_hurt(hitbox: HitboxComponent):
	if (entity and !entity.is_queued_for_deletion()) and !is_expired:
		if entity.faction != Enums.FactionType.None:
			if (target_allies and hitbox.entity.faction != entity.faction):
				return
			if (!target_allies and hitbox.entity.faction == entity.faction):
				return
		if hitbox.entity:
			var scale_factor = entity.action_component.actor_on_hurt_scale.get_final_value() * hitbox.entity.action_component.target_on_hurt_scale.get_final_value()
			for action in actions_on_hurt:
				action.execute(entity, hitbox.entity, scale_factor)
			entity.hurt.emit(hitbox.entity)
		hitbox.hit.emit(entity)
		current_pierce -= 1
		if is_expired:
			ProjectileHandler.remove(self)
