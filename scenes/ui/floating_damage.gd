extends Marker2D
class_name DamageFloat

@onready var label: Label = $Label
@onready var timer: Timer = $Timer

var amount: float = 0
var speed: float = 1
var gravity: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.UP

func _ready() -> void:
	timer.wait_time = randf_range(1, 1.5)
	speed = randf_range(2, 2.5)
	direction = direction.rotated(deg_to_rad(randf_range(-10, 10))).normalized()
	top_level = true
	label.text = str(amount)
	timer.start()

func _process(delta: float) -> void:
	gravity *= 1.01
	global_position += (gravity + (direction * speed))

func update(pos: Vector2, damage: float) -> void:
	global_position = pos
	amount = roundf(damage)

func _on_timer_timeout() -> void:
	queue_free()
