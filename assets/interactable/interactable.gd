extends StaticBody2D
class_name Interactable

@export var action_name: String
@export var interact_name: String

func interact(body: Node2D) -> void:
	print("Interact!")

func get_interact_name() -> String:
	return interact_name

func get_action_name() -> String:
	return "%s (%s)" % [action_name, InputMap.action_get_events("interact")[0].as_text()[0]]
