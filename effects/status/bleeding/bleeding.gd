class_name BleedingEffect
extends Effect

## Deals slash damage at regular intervals while active. Damage scales with number of stacks.

## The time between applying damage ticks.
@export var interval_time: float
## The amount of damage to deal per stack.
@export var damage_amount: float

var health_component: HealthComponent
var interval_timer: float
var damage_data: DamageData:
	get:
		return DamageData.new(damage_amount * stacks, Enums.DamageType.Slash)

func init(effect_component: EffectComponent) -> void:
	health_component = effect_component.health_component
	health_component.damage(damage_data)

func process(delta: float) -> void:
	if !health_component:
		expired.emit()
	else:
		interval_timer += delta
		if interval_timer >= interval_time:
			health_component.damage(damage_data)
			interval_timer -= interval_time
		duration_timer += delta
		if duration_timer >= duration_time:
			remove_stacks(1)
			duration_timer -= duration_time
