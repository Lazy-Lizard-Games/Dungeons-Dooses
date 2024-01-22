extends Node
class_name StateComponent

@export
var starting_state: State

var current_state: State


func init(entity: Entity) -> void:
	for child in get_children():
		child.entity = entity
	change_state(starting_state)


func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()


func process_physics(delta: float) -> void:
	if !current_state:
		return
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)


func process_frame(delta: float) -> void:
	if !current_state:
		return
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)


func process_input(event: InputEvent) -> void:
	if !current_state:
		return
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)
