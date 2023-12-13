extends Node2D
class_name DamageText

@export var label: Label
@export var timer: Timer
@export var colors: DamageColorData

var damage: DamageData:
	set(d):
		damage = d
		label.text = String.num(damage.amount, 3)
		label.add_theme_color_override('font_color', colors.getColorForType(damage.type))
var type: Globals.DAMAGE

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
