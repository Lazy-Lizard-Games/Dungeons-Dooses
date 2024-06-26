class_name ImpactData
extends Resource

## The impact data is information that will be transferred from a hurtbox to a hitbox on impact.

## The damages to deal on impact.
@export var damages: Array[DamageData]
## The knockback to apply on impact.
@export var knockback: float
## The active effects to apply on impact.
@export var effects: Array[EffectData]

func _init(default_damages: Array[DamageData]=[], default_knockback: float=0, default_effects: Array[EffectData]=[]) -> void:
	damages = default_damages
	knockback = default_knockback
	effects = default_effects