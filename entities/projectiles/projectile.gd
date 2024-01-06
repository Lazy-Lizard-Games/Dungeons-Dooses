extends Entity
class_name Projectile

## Projectiles are entities that can hit and navigate.

## Pierce maximum of the projectile, where anything less than zero results in infinite pierce.
@export var pierce: int
## Duration of the projectile, where anything less than zero results in infinite duration.
@export var duration: float
## Hurtbox responsible for triggering hits.
@export var hurtbox_component: HurtboxComponent

## Entity responsible for spawning the projectile, if any.
var entity: Entity
## Direction that the projectile is currently facing.
var direction: Vector2
## Current pierce of the projectile
var current_pierce: int


func _ready() -> void:
	super()
	current_pierce = pierce
	if hurtbox_component:
		hurtbox_component.hurt.connect(
			func(hitbox: HitboxComponent):
				if !hitbox.entity:
					return
				if faction != Enums.FactionType.None and hitbox.entity.faction == faction:
					return
				hurt.emit(hitbox.entity)
				if entity:
					entity.hurt.emit(hitbox.entity)
				hitbox.hit.emit(self)
				if pierce > 0:
					current_pierce -= 1
					if current_pierce == 0:
						ProjectileHandler.remove(self)
		)
	if duration > 0:
		var duration_timer = Timer.new()
		duration_timer.timeout.connect(
			func():
				ProjectileHandler.remove(self)
		)
		add_child(duration_timer)
		duration_timer.start(duration)
