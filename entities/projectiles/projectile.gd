extends Entity
class_name Projectile

## Projectiles are entities that can hit and navigate.

## Mob responsible for spawning the projectile, if any.
@export var mob: Mob
## Hurtbox responsible for triggering hits.
@export var hurtbox_component: HurtboxComponent
## Affinity attributes for the projectile.
@export var affinity_attributes: AffinityAttributes


func _ready() -> void:
	super()
	if hurtbox_component:
		hurtbox_component.hurt.connect(
			func(hitbox: HitboxComponent):
				if !hitbox.entity:
					return
				hurt.emit(self, hitbox.entity)
				hitbox.hit.emit(self)
		)
