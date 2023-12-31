extends EntityAction
class_name AddVelocityAction

## Adds velocity to the entity.

## Direction of velocity.
@export var direction: Vector2
## Magnitude of velocity.
@export var speed: float


func execute(entity: Entity) -> void:
	if condition:
		if !condition.execute(entity):
			return
	entity.velocity_component.add_velocity(direction * speed)
