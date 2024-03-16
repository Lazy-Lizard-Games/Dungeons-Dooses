extends Projectile

## Projectile for the smite ability of the warrior

## The damage dealt by the projectile.
@export var damage: DamageBientityAction
## The knockback dealt by the projectile.
@export var knockback: KnockbackBientiyAction
## The scene of the smited effect dealt by the projectile.
@export var smite_effect_scene: PackedScene
## The animation player for the projectile.
@export var animation: AnimationPlayer

func _ready():
  animation.play('trail')
  animation.animation_finished.connect(on_finished, CONNECT_ONE_SHOT)

func on_finished(_anim_name: StringName) -> void:
  ProjectileHandler.remove_projectile(self)

func _on_hurtbox_component_hurt(hitbox: HitboxComponent):
  if hitbox.entity.faction != entity.faction:
    # Apply damage
    damage.execute(entity, hitbox.entity)
    # Apply knockback
    var knockback_direction = ConstantVector.new(direction.x, direction.y)
    knockback.direction = knockback_direction
    knockback.execute(entity, hitbox.entity)
    # Apply smited effect
    var add_effect = AddEffectEntityAction.new()
    add_effect.effect_scene = smite_effect_scene
    add_effect.execute(hitbox.entity)
    ## Tell parent entity of hit
    entity.hurt.emit(hitbox.entity)
