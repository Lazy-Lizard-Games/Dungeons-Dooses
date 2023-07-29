extends Interactable

signal toggle_ability_manager()
var interacting_body: Node2D = null

func interact(body: Node2D) -> void:
	toggle_ability_manager.emit()

func _physics_process(delta: float) -> void:
	if interacting_body:
		if position.distance_to(interacting_body.position) > 50:
			clear_body()
			toggle_ability_manager.emit()

func clear_body() -> void:
	interacting_body = null
