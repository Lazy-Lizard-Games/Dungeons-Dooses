class_name WeakenedEffect
extends Effect

## The weakened effect is caused when a target is inflicted with both the bleeding and chilled effects
## Lowers physical damage modifiers. Scales with stacks.

const P_DAMAGE_UID = &"weakened"

## The decrease to the damage done by the target
@export var physical_damage_decrease: float

var stats_component: StatsComponent
var damage_modifier: AttributeModifier 

func process(delta):
	duration_timer += delta
	if duration_timer >= duration_time:
		remove_stacks(1)
		duration_timer -= duration_time

func init(effect_component: EffectComponent) -> void:
	stats_component = effect_component.stats_component
	damage_modifier = AttributeModifier.new(P_DAMAGE_UID, Enums.OperationType.Addition, physical_damage_decrease * stacks)
	stats_component.knockback_affinity.add_modifier(damage_modifier)
	stats_component.slash_affinity.add_modifier(damage_modifier)
	stats_component.pierce_affinity.add_modifier(damage_modifier)
	stats_component.blunt_affinity.add_modifier(damage_modifier)
	stacks_changed.connect(_on_weakened_stacks_changed)
	
func _on_weakened_stacks_changed(_old: int, current: int) -> void:
	damage_modifier.value = physical_damage_decrease * current
	
func exit() -> void:
	stats_component.knockback_affinity.remove_modifier(P_DAMAGE_UID)
	stats_component.slash_affinity.remove_modifier(P_DAMAGE_UID)
	stats_component.pierce_affinity.remove_modifier(P_DAMAGE_UID)
	stats_component.blunt_affinity.remove_modifier(P_DAMAGE_UID)
