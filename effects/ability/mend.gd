class_name MendEffect
extends Effect

## Heals any affected at regular intervals while active. Heal scales with stacks.

## The time between healing.
@export var interval_time: float
## The amount of damage to deal per stack.
@export var heal_amount: float

var health_component: HealthComponent
var interval_timer: float

func init(effect_component: EffectComponent) -> void:
	health_component = effect_component.health_component

func process(delta: float) -> void:
	if !health_component:
		expired.emit()
	else:
		interval_timer += delta
		if interval_timer >= interval_time:
			health_component.heal(heal_amount * stacks)
			interval_timer -= interval_time
		duration_timer += delta
		if duration_timer >= duration_time:
			remove_stacks(1)
			duration_timer -= duration_time
