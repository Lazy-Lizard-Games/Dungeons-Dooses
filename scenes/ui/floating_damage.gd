extends Marker2D
class_name DamageFloat

@onready var label: Label = $Label
@onready var timer: Timer = $Timer

var amount: float = 0

func _ready() -> void:
	top_level = true
	label.text = str(amount)
	timer.start()

func _process(delta: float) -> void:
	global_position.y -= 50 * delta

func update(pos: Vector2, damage: float) -> void:
	global_position = pos
	amount = roundf(damage)

func _on_timer_timeout() -> void:
	queue_free()
