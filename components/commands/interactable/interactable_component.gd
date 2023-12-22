extends Area2D
class_name InteractableComponent

signal interacted(interactor: InteractorComponent)

## Interation type
@export var type: Enums.InteractionType
## Interaction name
@export var action: String


func interact(interactor: InteractorComponent) -> void:
	interacted.emit(interactor)
