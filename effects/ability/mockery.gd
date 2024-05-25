class_name MockeryEffect
extends Effect

## Reduces physical damage dealt from shear embarressment!

const UID = &"Mockery"

@export var physical_affinity: float

var stats_component: StatsComponent

func init(effect_component: EffectComponent) -> void:
	stats_component = effect_component.stats_component
	if stats_component:
		var affinity_modifier = AttributeModifier.new(UID, Enums.OperationType.Addition, physical_affinity)
		stats_component.physical_affinity.add_modifier(affinity_modifier)

func exit() -> void:
	if stats_component:
		stats_component.physical_affinity.remove_modifier(UID)

func process(delta: float) -> void:
	duration_timer += delta
	if duration_timer >= duration_time:
		remove_stacks(1)
		duration_timer -= duration_time
