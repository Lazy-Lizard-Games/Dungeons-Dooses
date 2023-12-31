extends Entity
class_name Projectile

## Projectiles are entities that can hit and navigate.

## Hurtbox responsible for triggering hits.
@export var hurtbox_component: HurtboxComponent
## Affinity attributes for the projectile.
@export var affinity_attributes: AffinityAttributes

## Entity responsible for spawning the projectile, if any.
var entity: Entity
## Direction that the projectile is currently facing.
var direction: Vector2

func _ready() -> void:
	super()
	if hurtbox_component:
		hurtbox_component.hurt.connect(
			func(hitbox: HitboxComponent):
				if !hitbox.entity:
					return
				hurt.emit(self, hitbox.entity)
				if entity:
					hurt.emit(entity, hitbox.entity)
				hitbox.hit.emit(self)
		)
