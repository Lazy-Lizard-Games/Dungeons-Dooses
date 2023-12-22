extends Node2D
class_name DroppedItem

@export var interactable: InteractableComponent
@export var item: ItemData
@export var count: int


func _ready() -> void:
	interactable.interacted.connect(on_interacted)


func on_interacted(interactor: InteractorComponent) -> void:
	interactor.picked_up.emit(item, count)
	queue_free()
