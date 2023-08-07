extends Node
class_name StateManager

var states: Array[Callable] = []
var current_state : Callable

func add_state(state: Callable) -> void:
	if state not in states:
		states.append(state)

func set_initial_state(state: Callable) -> void:
	if state in states:
		current_state = state

func change_state(state: Callable) -> void:
	if state in states:
		current_state = state

func update() -> void:
	current_state.call()
