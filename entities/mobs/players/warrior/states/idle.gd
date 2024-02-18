extends State

@export var move_state: State
@export var attack_state: State
@export var velocity_component: VelocityComponent
@export var ability_component: AbilityComponent
@export var animation_tree: AnimationTree

var interactable: InteractableComponent


func enter() -> void:
	animation_tree['parameters/playback'].travel('idle')
	entity.render_component.update_animation('idle')


func exit() -> void:
	pass


func process_physics(_delta: float) -> State:
	if Input.is_action_pressed("primary") and entity.can_attack:
		return attack_state
	if Input.get_vector("move_left", "move_right", "move_up", "move_down").length() > 0:
		return move_state
	velocity_component.decelerate()
	velocity_component.move(entity)
	return null


func process_input(_event: InputEvent) -> State:
	return null

