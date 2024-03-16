extends Entity
class_name Mob

## Mobs are for entities that can take damage and be manipulated via actions.

## Hitbox component for the entity.
@export var hitbox_component: HitboxComponent
## Health component for the entity.
@export var health_component: HealthComponent

func _ready() -> void:
	super()
	hitbox_component.hit.connect(
		func(actor: Entity):
			hit.emit(actor)
	)
	health_component.attributes = generics
	health_component.died.connect(
		func():
			died.emit()
	)
