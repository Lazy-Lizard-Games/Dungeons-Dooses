extends Resource
class_name ProjectileObject

## Describes a basic projectile.

## Projectile name.
@export var name: String
## Projectile pierce.
@export var pierce: int
## Projectile duration.
@export var duration: Number
## Projectile speed.
@export var speed: Number
## Projectile actions on hurt.
@export var actions_on_hurt: Array[BientityAction]
