class_name ImpactData
extends Resource

## The impact data is information that will be transferred from a hurtbox to a hitbox on impact.

## The damages to deal on impact.
@export var damages: Array[DamageData]
## The knockback to apply on impact.
@export var knockback_strength: float
## The active effects to apply on impact.
@export var active_effects: Array[PackedScene]
