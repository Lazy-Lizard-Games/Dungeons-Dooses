extends Node2D

@onready var interact_area: Area2D = $InteractArea
@onready var interact_label: CenterContainer = $Canvas/Interactable
@onready var interact_name: Label = $Canvas/Interactable/HBox/InteractName
@onready var action_name: Label = $Canvas/Interactable/HBox/ActionName
@onready var player: CharacterBody2D = $".."

func _physics_process(delta: float) -> void:
	interact_label.hide()
	if interact_area.has_overlapping_bodies():
		var interactable = get_interactable()
		action_name.set_text(interactable.get_action_name())
		interact_name.set_text(interactable.get_interact_name())
		var ip = interactable.get_global_transform_with_canvas().origin
		interact_label.set_global_position(ip)
		interact_label.show()

func interact() -> void:
	if interact_area.has_overlapping_bodies():
		var interactable = get_interactable()
		interactable.interact(player)

func get_interactable() -> Node:
	return Utility.get_closest_body(player, interact_area.get_overlapping_bodies())
