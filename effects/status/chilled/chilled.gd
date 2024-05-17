class_name ChilledEffect
extends Effect

## The chilled effect reduces movement and attack speed of the target. Effect scales with stacks.

const MOVEMENT_UID = &"ChilledMovement"
const ATTACK_UID = &"ChilledAttack"

## The decrease to the movement speed of the target. I.e.: 0.5 -> 50% decrease.
@export var movement: float
## The decrease to the attack speed of the target. I.e.: 0.5 -> 50% decrease.
@export var attack: float

var stats_component: StatsComponent
var movement_modifier: AttributeModifier
var attack_modifier: AttributeModifier

func init(effect_component: EffectComponent) -> void:
	stats_component = effect_component.stats_component
	movement_modifier = AttributeModifier.new(MOVEMENT_UID, Enums.OperationType.Addition, -movement * stacks)
	stats_component.movement_speed.add_modifier(movement_modifier)
	attack_modifier = AttributeModifier.new(ATTACK_UID, Enums.OperationType.Addition, -attack * stacks)
	stats_component.cast_rate.add_modifier(attack_modifier)
	stacks_changed.connect(_on_chilled_stacks_changed)

func process(delta):
	duration_timer += delta
	if duration_timer >= duration_time:
		remove_stacks(1)
		duration_timer -= duration_time

func exit() -> void:
	stats_component.movement_speed.remove_modifier(MOVEMENT_UID)
	stats_component.cast_rate.remove_modifier(ATTACK_UID)

func _on_chilled_stacks_changed(_old: int, current: int) -> void:
	movement_modifier.value = -movement * current
	attack_modifier.value = -attack * current