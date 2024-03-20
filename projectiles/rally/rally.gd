extends Projectile

## Rally projectile increases health regen for nearby allies of the entity.

## Scene of the effect to apply to allies periodically.
@export var rally_effect_scene: PackedScene
## Animation player for animations.
@export var animation: AnimationPlayer
## Hurtbox component for detecting allies.
@export var hurtbox: HurtboxComponent
## Projectile duration in seconds.
@export var duration: float
## Interval duration in seconds.
@export var interval: float
@export var sprite: Sprite2D
var timer: Timer
var interval_timer: Timer

func _ready():
  look_at(global_position + Vector2.RIGHT)
  if direction.x < 0:
    sprite.flip_h = true
  # Start animation
  animation.play('trail')
  # Start duration timer
  timer = Timer.new()
  add_child(timer)
  timer.timeout.connect(on_timeout, CONNECT_ONE_SHOT)
  timer.start(duration)
  # Start interval timer
  interval_timer = Timer.new()
  add_child(interval_timer)
  interval_timer.timeout.connect(on_interval_timer_timeout)
  interval_timer.start(interval)

func on_timeout() -> void:
  ProjectileHandler.remove_projectile(self)

func on_interval_timer_timeout() -> void:
  hurtbox.force_check()

func _on_hurtbox_component_hurt(hitbox: HitboxComponent):
  if hitbox.entity.faction == entity.faction:
    # Apply rally effect
    var add_effect = AddEffect.new()
    add_effect.effect_scene = rally_effect_scene
    add_effect.execute(hitbox.entity)
    ## Tell hitbox it has been hit by entity
    hitbox.hit_by(entity)
    ## Tell entity it has hit hitbox entity
    entity.hurt.emit(hitbox.entity)
