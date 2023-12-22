extends ItemData
class_name ConsumableData

enum state {
	Ready,
	Cooldown
}

## Effect datas.
@export var effects: Array[EffectData]
## Cooldown before reuse.
@export var cooldown: float
## Current state
var current_state := state.Ready


func consume(effect_component: EffectComponent) -> void:
	if current_state != state.Ready:
		return
	for effect_data in effects:
		var effect = effect_data.effect.instantiate()
		effect_component.add_effect(effect)
	current_state = state.Cooldown
	TimerKeeper.create_timer(cooldown).timeout.connect(func(): current_state = state.Ready)
