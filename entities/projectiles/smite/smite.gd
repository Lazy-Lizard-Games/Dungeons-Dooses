extends Projectile

## Projectile for the smite ability of the warrior

## The damage dealt by the projectile.
@export var damage: DamageEntityWithTransforms
## The knockback dealt by the projectile.
@export var knockback: KnockbackEntityWithTransforms
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
		var add_effect = AddActiveEffectWithTransforms.new(smite_effect_scene)
		add_effect.execute(entity, hitbox.entity)
		## Tell hitbox it has been hit by entity
		hitbox.hit_by(entity)
		## Tell entity it has hit hitbox entity
		entity.hurt.emit(hitbox.entity)
