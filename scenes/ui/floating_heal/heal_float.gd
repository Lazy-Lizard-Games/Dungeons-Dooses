extends Marker2D
class_name HealFloat

@export var colour: Color = Color.PALE_GREEN
@export var heal: float = 0
@export var speed: float = 2
@export var gravity: Vector2 = Vector2.DOWN
@export var direction: Vector2 = Vector2.UP

@onready var label: Label = $Label
@onready var timer: Timer = $Timer


func _ready() -> void:
	top_level = true
	timer.wait_time = randf_range(1, 1.5)
	speed = randf_range(2, 2.5)
	direction = direction.rotated(deg_to_rad(randf_range(-10, 10))).normalized()
	label.text = "%.1f" % heal if heal < 1.0 else "%s" % heal
	label["theme_override_colors/font_color"] = colour
	timer.start()


func _process(delta: float) -> void:
	gravity *= 1.01
	global_position += (gravity + (direction * speed))


func _on_timer_timeout() -> void:
	queue_free()
