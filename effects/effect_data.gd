class_name EffectData
extends Resource

## Describes how an effect should be applied.

## The effect to be applied.
@export var effect: Effect
## The stacks of the effect to apply.
@export var stacks: int

func _init(default_effect: Effect=null, default_stacks: int=0):
	effect = default_effect
	stacks = default_stacks