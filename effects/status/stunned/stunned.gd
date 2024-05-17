class_name StunnedEffect
extends Effect

## The stunned effect will prevent the affected target from moving or attacking.

@export var stunned_state_scene: PackedScene
var state_component: StateComponent

func init(effect_component: EffectComponent) -> void:
	state_component = effect_component.state_component
	var state: State = stunned_state_scene.instantiate()
	state.entity = state_component.entity
	state.velocity_component = effect_component.velocity_component
	state_component.change_state(state)

func process(delta: float) -> void:
	duration_timer += delta
	if duration_timer >= duration_time:
		remove_stacks(1)
		duration_timer -= duration_time

func exit() -> void:
	state_component.change_state(state_component.starting_state)
