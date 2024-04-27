extends Area2D
class_name HurtboxComponent

## Emitted when damage has been dealt.
signal damage_dealt(amount: float, type: Enums.DamageType, to: HitboxComponent)
## Emiited when knockback been applied.
signal knockback_applied(strength: float, to: HitboxComponent)
## Emitted when an effect as been applied.
signal effect_applied(effect: Effect, to: HitboxComponent)
## Mayhaps deprecated...
signal hurt(hitbox: HitboxComponent)

## Data to transfer on impact with a hitbox.
@export var impact_data: ImpactData

## Collection of already hit targets.
var hit_targets: Array[HitboxComponent] = []

func on_area_collision(area: Area2D) -> void:
	if area is HitboxComponent:
		if area.detect_only:
			return
		if area in hit_targets:
			return
		hit_targets.append(area)
		area.handle_impact(impact_data, self)

func force_check() -> void:
	for area in get_overlapping_areas():
		on_area_collision(area)