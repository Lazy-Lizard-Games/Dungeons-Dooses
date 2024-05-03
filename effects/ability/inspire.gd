class_name InspireEffect
extends Effect

## Increases physical defence and attack for short duration. Effect scales with stacks.

const RESISTANCE_UID = &"InspireResistance"
const AFFINITY_UID = &"InspireAffinity"

## The physical resistance increase per stack as percentage. I.e.: 0.5 -> 50% increase.
@export var physical_resistance: float
## The physical affinity increase per stack as percentage. I.e.: 0.5 -> 50% increase.
@export var physical_affinity: float

var stats_component: StatsComponent

func init(effect_component: EffectComponent) -> void:
	stats_component = effect_component.stats_component
	if stats_component:
		var resistance_modifier = AttributeModifier.new(RESISTANCE_UID, Enums.OperationType.Addition, physical_resistance)
		var affinity_modifier = AttributeModifier.new(AFFINITY_UID, Enums.OperationType.Addition, physical_affinity)
		stats_component.slash_resistance.add_modifier(resistance_modifier)
		stats_component.pierce_resistance.add_modifier(resistance_modifier)
		stats_component.blunt_resistance.add_modifier(resistance_modifier)
		stats_component.slash_affinity.add_modifier(affinity_modifier)
		stats_component.pierce_affinity.add_modifier(affinity_modifier)
		stats_component.blunt_affinity.add_modifier(affinity_modifier)

func exit() -> void:
	if stats_component:
		stats_component.slash_resistance.remove_modifier(RESISTANCE_UID)
		stats_component.pierce_resistance.remove_modifier(RESISTANCE_UID)
		stats_component.blunt_resistance.remove_modifier(RESISTANCE_UID)
		stats_component.slash_affinity.remove_modifier(AFFINITY_UID)
		stats_component.pierce_affinity.remove_modifier(AFFINITY_UID)
		stats_component.blunt_affinity.remove_modifier(AFFINITY_UID)

func process(delta: float) -> void:
	if !stats_component:
		expired.emit()
	else:
		duration_timer += delta
		if duration_timer >= duration_time:
			remove_stacks(1)
			duration_timer -= duration_time
