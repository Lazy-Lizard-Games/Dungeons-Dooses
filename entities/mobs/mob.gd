extends Entity
class_name Mob

## Mobs are for entities that can take damage and be manipulated via actions.

## Hitbox component for the entity.
@export var hitbox_component: HitboxComponent
## Health component for the entity.
@export var health_component: HealthComponent
## Resistance attributes for the entity.
@export var resistance_attributes: ResistanceAttributes
## Affinity attributes for the entity.
@export var affinity_attributes: AffinityAttributes


func _ready() -> void:
	super()
	if hitbox_component:
		hitbox_component.hit.connect(
			func(actor: Entity):
				hit.emit(actor, self)
		)
	health_component.attributes = generic_attributes
