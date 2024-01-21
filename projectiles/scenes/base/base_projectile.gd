extends CharacterBody2D
class_name BaseProjectile

## Projectiles are spawned by entities and allow for hit/hurt triggers at range.

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
var direction: VectorAction
## Actions to execute on hurt.
var actions_on_hurt: Array[BientityAction]
## Entity responsible for spawning the projectile, if any.
var entity: Entity
## Current pierce of the projectile.
var current_pierce: int
## Current direction of the projectile.
var _direction: Vector2


func set_variables(projectile_object: BaseProjectileObject) -> void:
	id = projectile_object.name
	pierce = projectile_object.pierce
	duration = projectile_object.duration
	direction = projectile_object.direction
	actions_on_hurt = projectile_object.actions_on_hurt
	collision_shape.shape = projectile_object.shape
	hurtbox_collision_shape.shape = projectile_object.shape
	self.scale = Vector2.ONE * projectile_object.scale.execute()


func _ready() -> void:
	_direction = direction.get_vector(entity)
	look_at(global_position + _direction)
	current_pierce = pierce
	hurtbox_component.hurt.connect(on_hurt)
	var _duration = duration.execute()
	if _duration > 0:
		var duration_timer = Timer.new()
		duration_timer.timeout.connect(
			func():
				ProjectileHandler.remove(self)
		)
		add_child(duration_timer)
		duration_timer.start(_duration)


func on_hurt(hitbox: HitboxComponent):
	if entity:
		if entity.faction != Enums.FactionType.None and hitbox.entity.faction == entity.faction:
			return
		if hitbox.entity:
			for action in actions_on_hurt:
				action.execute(entity, hitbox.entity)
			entity.hurt.emit(hitbox.entity)
		hitbox.hit.emit(entity)
		current_pierce -= 1
		if current_pierce <= 0 and pierce > 0:
			ProjectileHandler.remove(self)
