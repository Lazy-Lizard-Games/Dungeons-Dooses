@tool
extends MarginContainer

@export var title: String:
	set(new_title):
		title = new_title
		set_title(title)

@onready var button: Button = $Button

func set_title(new_title: String) -> void:
	button.text = new_title


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

