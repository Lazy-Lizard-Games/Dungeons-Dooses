extends Resource
class_name BaseProjectileObject

## Describes a basic projectile.

## Projectile name.
@export var name: String
## Projectile pierce.
@export var pierce: int
## Projectile duration.
@export var duration: Number
## Projectile direction.
@export var direction: Vector
## Projectile scale.
@export var scale: Number
## Projectile collision shape.
@export var shape: Shape2D
## Projectile collision shape offset.
@export var shape_offset: Vector2
## Projectile actions on hurt.
@export var actions_on_hurt: Array[BientityAction]
## Projectile sprite frames.
@export var sprite_frames: SpriteFrames
## Toggles the projectile to only hit a target once, even if they remain in the collision area.
@export var single_hit: bool
