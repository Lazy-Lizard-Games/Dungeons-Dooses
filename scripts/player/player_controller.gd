extends Character

@export var inventory_data: InventoryData
@onready var interact_area: Area2D = $InteractArea
@onready var interact_label: Label = $UI/Interactions/InteractLabel
@onready var interact_hover: TextureRect = $UI/Interactions/InteractHover

signal toggle_inventory

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
	
	if Input.is_action_just_pressed("interract"):
		if interact_area.has_overlapping_bodies():
			var interactable = interact_area.get_overlapping_bodies()[0]
			if global_position.distance_to(interactable.global_position) <= reach:
				interactable.player_interact()

func _physics_process(delta) -> void:
	# Update interract area
	interact_area.global_position = get_global_mouse_position()
	interact_label.hide()
	if interact_area.has_overlapping_bodies():
		var interactable = interact_area.get_overlapping_bodies()[0]
		interact_label.text = interactable.name
		# Center label below cursor
		interact_label.global_position = get_viewport().get_mouse_position()
		interact_label.global_position += Vector2(-interact_label.get_rect().size.x/2, 10)
		interact_label.show()
	
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
