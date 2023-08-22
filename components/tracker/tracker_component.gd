extends Area2D
class_name TrackerComponent

signal target_updated(target)

@export var faction: Globals.FACTIONS

var targetables: Array[Node2D] = []
var target: Node2D :
	set(body):
		target = body
		target_updated.emit(body)


func update_target() -> void:
	targetables.sort_custom(sort_closer)
	target = targetables[0]


func sort_closer(a: Node2D, b: Node2D) -> bool:
	if global_position.distance_to(a.global_position) < global_position.distance_to(b.global_position):
		return true
	return false


func _on_body_entered(body: Node2D) -> void:
	if body.faction not in Relationships.get_allies_for(faction):
		targetables.append(body)
		if not target:
			target = body


func _on_body_exited(body: Node2D) -> void:
	if body in targetables:
		targetables.remove_at(targetables.find(body))
		if target == body:
			target = null
