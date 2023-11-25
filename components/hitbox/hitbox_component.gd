extends Area2D
class_name HitboxComponent

## Triggered whenever damage is dealt to the hitbox.
signal hit_by_damage(damage: DamageData, source: HurtboxComponent)
## Triggered whenever an effect is applied to the hitbox.
signal hit_by_effect(effect: EffectData, source: HurtboxComponent)
## Triggered whenever the hitbox is knocked back by an attack.
signal hit_by_knockback(knockback: KnockbackData, source: HurtboxComponent)


@export
var detect_only := false


func handle_collision(collision: CollisionData, source: HurtboxComponent) -> void:
	if detect_only:
		return
	
	for damage in collision.damages:
		handle_damage(damage, source)
	
	for effect in collision.effects:
		handle_effect(effect, source)
	
	for knockback in collision.knockbacks:
		handle_knockback(knockback, source)


func handle_damage(damage: DamageData, source: HurtboxComponent) -> void:
	if detect_only:
		return
	hit_by_damage.emit(damage, source)


func handle_effect(effect: EffectData, source: HurtboxComponent) -> void:
	if detect_only:
		return
	hit_by_effect.emit(effect, source)


func handle_knockback(knockback: KnockbackData, source: HurtboxComponent) -> void:
	if detect_only:
		return
	knockback.direction = source.global_position.direction_to(global_position)
	hit_by_knockback.emit(knockback, source)
