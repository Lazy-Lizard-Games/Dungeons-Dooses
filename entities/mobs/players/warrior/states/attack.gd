extends State

@export var idle_state: State
@export var move_state: State
@export var velocity_component: VelocityComponent
@export var ability_component: AbilityComponent
@export var state_component: StateComponent
@export var animation_tree: AnimationTree

var direction := Vector2.ZERO
var ability: Ability
var ability_state: State

func enter() -> void:
	ability = ability_component.start_ability(entity.get_selected_ability_index(), entity)
	for child in get_children():
		if ability.uid == child.name:
			ability_state = child
			ability_state.ability = ability
			ability_state.entity = entity
			break
	if !ability_state:
		state_component.change_state(idle_state)
		return
	ability_state.enter()

func exit() -> void:
	if ability_state:
		ability_state.exit()
		ability_state = null
	if ability:
		ability = null

func process_physics(delta: float) -> State:
	var state = ability_state.process_physics(delta)
	return state

func process_input(_event: InputEvent) -> State:
	# if Input.is_action_just_released("primary"):
	# 	ability.release(entity)
	# 	return null
	# if Input.is_action_just_pressed("secondary"):
	# 	ability.cancel(entity)
	# 	return idle_state
	return null
