extends Area2D
class_name InteractorComponent

signal interactables_updated

var interactables: Array[InteractableComponent] = []


func get_first_interactable() -> InteractableComponent:
	if interactables.size() == 0:
		return
	interactables.sort_custom(i_sort)
	return interactables[0]


func _on_area_entered(area: Area2D) -> void:
	if area is InteractableComponent:
		interactables.append(area)
		interactables_updated.emit()


func _on_area_exited(area: Area2D) -> void:
	if area is InteractableComponent:
		interactables.erase(area)
		interactables_updated.emit()


func i_sort(a: InteractableComponent, b: InteractableComponent) -> bool:
	if position.distance_to(a.position) < position.distance_to(b.position):
		return true
	return false
