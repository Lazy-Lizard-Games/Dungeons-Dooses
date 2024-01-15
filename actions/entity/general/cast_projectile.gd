extends EntityAction
class_name CastProjecitleAction

## Projectile scene to create and cast for the entity.
@export var projectile: ProjectileObject
## Vector action to decide how to calculate projectile position.
@export var position: VectorAction = VectorAction.new()
## Vector action to decide how to calculate projectile direction.
@export var direction: VectorAction = VectorAction.new()


func execute(entity: Entity) -> void:
	var projectile_scene = load("res://projectiles/projectile.tscn").instantiate() as Projectile
	projectile_scene.set_variables(projectile)
	projectile_scene.entity = entity
	projectile_scene.direction = direction.get_vector(entity)
	projectile_scene.global_position = position.get_vector(entity)
	ProjectileHandler.add(projectile_scene)
