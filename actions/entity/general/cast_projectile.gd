extends EntityAction
class_name CastProjecitleAction

## Projectile scene to create and cast for the entity.
@export var projectile_scene: PackedScene
## Vector action to decide how to calculate projectile position.
@export var position: VectorAction = VectorAction.new()
## Vector action to decide how to calculate projectile direction.
@export var direction: VectorAction = VectorAction.new()


func execute(entity: Entity) -> void:
	var projectile = projectile_scene.instantiate() as Projectile
	projectile.entity = entity
	projectile.faction = entity.faction
	projectile.direction = direction.get_vector(entity)
	projectile.global_position = position.get_vector(entity)
	projectile.affinities.add_affinity_modifiers(entity.affinities)
	ProjectileHandler.add(projectile)
