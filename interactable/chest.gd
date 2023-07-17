extends Interactable

signal toggle_inventory(external_inventory_owner)

@export var inventory_data: InventoryData

var interacting_body: Node2D = null

func interact(body: Node2D) -> void:
	interacting_body = body
	toggle_inventory.emit(self)

func _physics_process(delta: float) -> void:
	if interacting_body:
		if position.distance_to(interacting_body.position) > 50:
			clear_body()
			toggle_inventory.emit(self)

func clear_body() -> void:
	interacting_body = null
