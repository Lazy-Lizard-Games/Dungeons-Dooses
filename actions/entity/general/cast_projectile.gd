extends EntityAction
class_name CastProjecitleAction

## Projectile scene to create and cast for the entity.
@export var projectile_scene: PackedScene
## Position at which to spawn the projectile
@export var position_vector: Vector = Vector.new()
## Direction at which to spawn the projectile
@export var direction_vector: Vector = Vector.new()

func execute(entity: Entity, _scale:=1.0) -> void:
	var position = position_vector.get_vector(entity)
	var direction = direction_vector.get_vector(entity)
	var projectile = projectile_scene.instantiate() as Projectile
	if projectile:
		projectile.init(entity, position, direction)
		ProjectileHandler.add_projectile(projectile)
	else:
		print_debug("Something went wrong...")
