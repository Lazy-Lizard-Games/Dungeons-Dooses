extends Area2D
class_name InteractableComponent

signal interacted(interactor: InteractorComponent)

## Interaction name
@export var action: String


func interact(interactor: InteractorComponent) -> void:
	interacted.emit(interactor)
