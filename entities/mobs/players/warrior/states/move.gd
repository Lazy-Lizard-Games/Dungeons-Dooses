extends State

@export var idle_state: State
@export var attack_state: State
@export var velocity_component: VelocityComponent
@export var ability_component: AbilityComponent
@export var animation_tree: AnimationTree

var direction := Vector2.ZERO

func enter() -> void:
	animation_tree['parameters/playback'].travel('walk')

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_physics(_delta: float) -> State:
	if Input.is_action_pressed("primary"):
		var ability = ability_component.get_ability(entity.get_selected_ability_index())
		if ability and ability.can_start(entity):
			return attack_state
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction.length() == 0:
		return idle_state
	velocity_component.accelerate_in_direction(direction)
	velocity_component.move(entity)
	animation_tree['parameters/walk/blend_position'] = direction.normalized()
	return null
