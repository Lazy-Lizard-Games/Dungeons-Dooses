extends Projectile

## Projectile for the slash ability of the warrior

@export var damage: DamageBientityAction
@export var knockback: KnockbackBientiyAction
@export var animation: AnimationPlayer

func _ready():
  animation.play('trail')
  animation.animation_finished.connect(on_finished, CONNECT_ONE_SHOT)

func on_finished(_anim_name: StringName) -> void:
  ProjectileHandler.remove_projectile(self)

func _on_hurtbox_component_hurt(hitbox: HitboxComponent):
  if hitbox.entity.faction != entity.faction:
    ## Apply damage
    damage.execute(entity, hitbox.entity)
    ## Apply knockback
    var knockback_direction = global_position.direction_to(hitbox.global_position)
    knockback.direction = ConstantVector.new(knockback_direction.x, knockback_direction.y)
    knockback.execute(entity, hitbox.entity)
    ## Tell hitbox it has been hit by entity
    hitbox.hit_by(entity)
    ## Tell entity it has hit hitbox entity
    entity.hurt.emit(hitbox.entity)
