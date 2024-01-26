extends EntityAction
class_name AddVelocityAction

## Adds velocity to the entity.

## Direction of velocity.
@export var direction: Vector2
## Magnitude of velocity.
@export var speed: Number


func execute(entity: Entity, scale := 1) -> void:
	if condition:
		if !condition.execute(entity):
			return
	entity.velocity_component.add_velocity(direction * speed.execute() * scale)
