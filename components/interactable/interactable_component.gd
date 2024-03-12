extends Area2D
class_name InteractableComponent

signal interacted(entity: Entity)


func interact(interactor: InteractorComponent) -> void:
	interacted.emit(interactor.entity)
