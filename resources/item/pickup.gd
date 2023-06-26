extends RigidBody2D

@export var slot_data: SlotData
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D

var time_alive = 0
var ignore_pickup_timer = 0
var _name = ""

func _ready() -> void:
	sprite_2d.texture = slot_data.item_data.texture
	_name = slot_data.item_data.name

func _physics_process(delta: float) -> void:
	if ignore_pickup_timer:
		ignore_pickup_timer -= delta
		if ignore_pickup_timer <= 0:
			area_2d.monitoring = true
	time_alive += delta
	position.y -= sin(time_alive)*0.05

func set_ignore_timer(timer: int):
	ignore_pickup_timer = timer
	area_2d.monitoring = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.inventory_data.pick_up_slot_data(slot_data):
		queue_free()
