extends Area2D
class_name InteractorComponent

signal interactables_updated

## Entity the interactor belongs to.
@export var entity: Entity
## Interactables currently within range.
var interactables: Array[InteractableComponent] = []


func interact() -> void:
	var interactable = get_first_interactable()
	if interactable:
		interactable.interact(self)


func get_first_interactable() -> InteractableComponent:
	if interactables.size() == 0:
		return null
	if interactables.size() == 1:
		return interactables[0]
	interactables.sort_custom(distance_sort)
	return interactables[0]


func _on_area_entered(area: Area2D) -> void:
	if area is InteractableComponent:
		interactables.append(area)
		interactables_updated.emit()


func _on_area_exited(area: Area2D) -> void:
	if area is InteractableComponent:
		interactables.erase(area)
		interactables_updated.emit()


func distance_sort(a: InteractableComponent, b: InteractableComponent) -> bool:
	if global_position.distance_to(a.global_position) < global_position.distance_to(b.global_position):
		return true
	return false
