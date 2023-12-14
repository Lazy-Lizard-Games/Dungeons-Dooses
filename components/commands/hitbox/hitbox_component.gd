extends Area2D
class_name HitboxComponent

## Triggered whenever damage is dealt to the hitbox.
signal hit_by_damage(damage_data: DamageData, source: HurtboxComponent)
## Triggered whenever an effect is applied to the hitbox.
signal hit_by_effect(effect: Effect)
## Triggered whenever the hitbox is knocked back by an attack.
signal hit_by_knockback(knockback_data: KnockbackData, source: HurtboxComponent)

@export
var faction := Globals.FACTION.NONE

@export
var detect_only := false


func handle_collision(collision_data: CollisionData, source: HurtboxComponent) -> void:
	if detect_only:
		return
	
	for damage_data in collision_data.damage_datas:
		handle_damage(damage_data, source)
	
	for effect_data in collision_data.effect_datas:
		handle_effect(effect_data, source)
	
	for knockback_data in collision_data.knockback_datas:
		handle_knockback(knockback_data, source)


func handle_damage(damage_data: DamageData, source: HurtboxComponent) -> void:
	if detect_only:
		return
	hit_by_damage.emit(damage_data, source)


func handle_effect(effect_data: EffectData, source: HurtboxComponent) -> void:
	if detect_only:
		return
	var effect = effect_data.effect.instantiate() as Effect
	hit_by_effect.emit(effect)


func handle_knockback(knockback_data: KnockbackData, source: HurtboxComponent) -> void:
	if detect_only:
		return
	hit_by_knockback.emit(knockback_data, source)
