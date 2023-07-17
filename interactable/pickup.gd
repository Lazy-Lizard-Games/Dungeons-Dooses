extends Interactable

@export var slot_data: SlotData
@onready var sprite_2d: Sprite2D = $Sprite2D

var time_alive = 0

func _ready() -> void:
	sprite_2d.texture = slot_data.item_data.texture
	interact_name = slot_data.item_data.name

func _physics_process(delta: float) -> void:
	time_alive += delta
	position.y -= sin(time_alive)*0.05

func interact(body: Node2D) -> void:
	if body.inventory_data.pick_up_slot_data(slot_data):
		queue_free()

func get_interact_name() -> String:
	return "%s x%s" % [interact_name, slot_data.quantity]
