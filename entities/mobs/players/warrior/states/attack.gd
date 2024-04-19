extends State

@export var idle_state: State
@export var move_state: State
@export var velocity_component: VelocityComponent
@export var ability_component: AbilityComponent
@export var state_component: StateComponent
@export var animation_tree: AnimationTree

var direction := Vector2.ZERO
var ability: Ability

func enter() -> void:
	ability = ability_component.cast_ability(entity.get_selected_ability_index(), entity)
	ability.state.entity = entity
	ability.state.enter()
	if !ability:
		state_component.change_state(idle_state)

func exit() -> void:
	ability.state.exit()
	pass

func process_physics(delta: float) -> State:
	var state = ability.state.process_physics(delta)
	return state

func process_frame(delta: float) -> State:
	var state = ability.state.process_frame(delta)
	return state

func process_input(event: InputEvent) -> State:
	var state = ability.state.process_input(event)
	return state
