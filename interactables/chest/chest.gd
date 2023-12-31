extends Node2D

@export var label: Label
@export var inventory: Array

var is_open := false


func _on_interactable_component_interacted(interactor: InteractorComponent) -> void:
	print("I've been touched!")
	is_open = !is_open
	label.visible = is_open
	interactor.opened.emit(inventory)
