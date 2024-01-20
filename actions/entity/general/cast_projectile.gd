extends EntityAction
class_name CastProjecitleAction

## Projectile scene to create and cast for the entity.
@export var projectile_object: BaseProjectileObject
## Vector action to decide how to calculate projectile position.
@export var position: VectorAction = VectorAction.new()


func execute(entity: Entity) -> void:
	var projectile := get_projectile_scene(projectile_object)
	projectile.set_variables(projectile_object)
	projectile.entity = entity
	projectile.global_position = position.get_vector(entity)
	ProjectileHandler.add(projectile)


func get_projectile_scene(object: BaseProjectileObject) -> BaseProjectile:
	if object is TravellingProjectileObject:
		return load("res://projectiles/scenes/travelling/travelling_projectile.tscn").instantiate()
	return load("res://projectiles/scenes/base/base_projectile.tscn").instantiate()
