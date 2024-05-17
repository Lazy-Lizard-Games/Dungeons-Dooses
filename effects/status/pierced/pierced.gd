class_name PiercedEffect
extends Effect

## The pierced effect reduces target physical resistances. Effect scales with stacks.

const RESISTANCE_UID = &"pierced"

## The decrease to the physical resistance of the target. I.e.: 0.5 -> 50% decrease.
@export var resistance: float

var stats_component: StatsComponent
var resistance_modifier: AttributeModifier

func init(effect_component: EffectComponent) -> void:
	stats_component = effect_component.stats_component
	resistance_modifier = AttributeModifier.new(RESISTANCE_UID, Enums.OperationType.Addition, -resistance * stacks)
	stats_component.slash_resistance.add_modifier(resistance_modifier)
	stats_component.pierce_resistance.add_modifier(resistance_modifier)
	stats_component.blunt_resistance.add_modifier(resistance_modifier)
	stacks_changed.connect(_on_pierced_stacks_changed)

func process(delta):
	duration_timer += delta
	if duration_timer >= duration_time:
		remove_stacks(1)
		duration_timer -= duration_time

func exit() -> void:
	stats_component.slash_resistance.remove_modifier(RESISTANCE_UID)
	stats_component.pierce_resistance.remove_modifier(RESISTANCE_UID)
	stats_component.blunt_resistance.remove_modifier(RESISTANCE_UID)

func _on_pierced_stacks_changed(_old: int, current: int) -> void:
	resistance_modifier.value = -resistance * current