extends Projectile

## Projectile for the smite ability of the warrior

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
    damage.execute(entity, hitbox.entity)
    var knockback_direction = ConstantVector.new(direction.x, direction.y)
    knockback.direction = knockback_direction
    knockback.execute(entity, hitbox.entity)
    entity.hurt.emit(hitbox.entity)
