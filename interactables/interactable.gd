extends StaticBody2D
class_name Interactable

## Interactables are things that can be interacted with in the world, such as doors or chests.

## Interactable component.
@export var interactable_component: InteractableComponent = InteractableComponent.new()


func _ready() -> void:
	interactable_component.interacted.connect(interacted)


func interacted(_entity: Entity) -> void:
	pass
