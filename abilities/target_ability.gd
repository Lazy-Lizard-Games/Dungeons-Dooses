extends Ability
class_name TargetAbility

## Projectile used to hit other entities.
@export var projectile_scene: PackedScene


func cast(entity: Entity, direction := Vector2.ZERO) -> void:
	super(entity, direction)
	casted.connect(
		func():
			var projectile = projectile_scene.instantiate() as Projectile
			projectile.entity = entity
			projectile.direction = direction
			projectile.global_position = entity.global_position
			ProjectileHandler.add(projectile)
	)
