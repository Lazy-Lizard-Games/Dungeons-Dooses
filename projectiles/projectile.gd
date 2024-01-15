extends CharacterBody2D
class_name Projectile

## Projectiles are spawned by entities and allow for hit/hurt triggers at range.

## Pierce maximum of the projectile, where anything less than zero results in infinite pierce.
@export var pierce: int
## Duration of the projectile, where anything less than zero results in infinite duration.
@export var duration: float
## Actions to execute on hurt.
@export var actions_on_hurt: Array[BientityAction]
## Hurtbox responsible for triggering hits.
@export var hurtbox_component: HurtboxComponent
## Velocity component to handle movement.
@export var velocity_component: VelocityComponent

## Entity responsible for spawning the projectile, if any.
var entity: Entity
## Direction that the projectile is currently facing.
var direction: Vector2
## Current pierce of the projectile
var current_pierce: int


func _ready() -> void:
	current_pierce = pierce
	if hurtbox_component:
		hurtbox_component.hurt.connect(on_hurt)
	if duration > 0:
		var duration_timer = Timer.new()
		duration_timer.timeout.connect(
			func():
				ProjectileHandler.remove(self)
		)
		add_child(duration_timer)
		duration_timer.start(duration)


func on_hurt(hitbox: HitboxComponent):
	if entity:
		if entity.faction != Enums.FactionType.None and hitbox.entity.faction == entity.faction:
			return
		if hitbox.entity:
			for action in actions_on_hurt:
				action.execute(entity, hitbox.entity)
			entity.hurt.emit(hitbox.entity)
		hitbox.hit.emit(entity)
		current_pierce -= 1
		if current_pierce <= 0 and pierce > 0:
			ProjectileHandler.remove(self)
