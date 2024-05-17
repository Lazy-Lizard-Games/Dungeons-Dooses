class_name EffectData
extends Resource

## Describes how an effect should be applied.

## The effect to be applied.
@export var effect: Effect
## The chance to apply the effect.
@export_range(0, 1) var chance: float
## The stacks of the effect to apply.
@export var stacks: int

func _init(default_effect: Effect=null, default_chance: float=0, default_stacks: int=1):
	effect = default_effect
	chance = default_chance
	stacks = default_stacks