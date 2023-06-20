extends Character

@export var inventory_data: InventoryData
@onready var interract_area: Area2D = $InterractArea
@onready var interract_label: Label = $UI/Interactions/InterractLabel

signal toggle_inventory

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
	
	if Input.is_action_just_pressed("interract"):
		if interract_area.has_overlapping_bodies():
			var interactable = interract_area.get_overlapping_bodies()[0]
			if global_position.distance_to(interactable.global_position) <= reach:
				interactable.player_interact()

func _physics_process(delta) -> void:
	# Update interract area
	interract_area.global_position = get_global_mouse_position()
	interract_label.hide()
	if interract_area.has_overlapping_bodies():
		interract_label.global_position = get_viewport().get_mouse_position() + Vector2(0, 10)
		interract_label.show()
		interract_label.text = interract_area.get_overlapping_bodies()[0].name
	
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
