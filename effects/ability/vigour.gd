class_name VigourEffect
extends Effect

## Increases the stamina regeneration of those affected.

const UID = &"Vigour"

## The modifier to stamina regeneration.
@export var stamina_regeneration: float

var stats_component: StatsComponent
var interval_timer: float

func init(effect_component: EffectComponent) -> void:
	stats_component = effect_component.stats_component
	var stamina_regen_modifier = AttributeModifier.new(UID, Enums.OperationType.Addition, stamina_regeneration)
	stats_component.stamina_regeneration.add_modifier(stamina_regen_modifier)

func exit() -> void:
	stats_component.stamina_regeneration.remove_modifier(UID)

func process(delta: float) -> void:
	duration_timer += delta
	if duration_timer >= duration_time:
		remove_stacks(1)
		duration_timer -= duration_time