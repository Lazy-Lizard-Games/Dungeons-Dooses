extends BaseProjectile
class_name LaserProjectile

@export var raycast: RayCast2D
@export var target_component: TargetComponent


func set_variables(projectile_object: BaseProjectileObject) -> void:
	super(projectile_object)
	projectile_object = projectile_object as LaserProjectileObject
	raycast.target_position *= int(projectile_object.raycast_length.execute())


func _ready() -> void:
	super()
	raycast.add_exception(entity)
	raycast.force_raycast_update()
	scan()


func scan() -> void:
	while raycast.is_colliding():
		var body = raycast.get_collider() as PhysicsBody2D
		if !(body is Mob) or body.faction == entity.faction:
			raycast.add_exception(body)
			raycast.force_raycast_update()
			continue
		global_position = body.global_position
		hurtbox_component.on_area_collision(body.hitbox_component)
		target_component.add_exception(body)
		var new_target = target_component.get_target(entity)
		if new_target:
			look_at(global_position + global_position.direction_to(new_target.global_position))
		raycast.force_raycast_update()
	ProjectileHandler.remove(self)
