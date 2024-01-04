extends Control
class_name DamageText

@export var label: Label
@export var timer: Timer
@export var colors: DamageColorData

var type: Enums.DamageType:
	set(t):
		type = t
		label.add_theme_color_override('font_color', colors.getColorForType(type))
var amount: float:
	set(a):
		amount = a
		label.text = String.num(amount, 3)
var direction := Vector2.UP
var speed := 5.0


func _ready() -> void:
	direction = direction.rotated(deg_to_rad(15-randf_range(0, 30)))
	timer.start(1)


func _physics_process(delta: float) -> void:
	direction = direction.lerp(Vector2.DOWN, delta)
	position += direction * speed


func _on_timer_timeout() -> void:
	queue_free()
