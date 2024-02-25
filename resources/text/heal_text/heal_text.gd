extends Control
class_name HealText

@export var timer: Timer
@export var label: Label
var amount: float:
	set(a):
		amount = a
		if amount > 1000000:
			label.text = String.num(amount/1000000.0, 0) + " M"
		elif amount > 100000:
			label.text = String.num(amount/1000.0, 0) + " K"
		else:
			label.text = String.num(amount, 0)
var speed := 1.0


func _ready():
	timer.start(2)


func _physics_process(delta: float) -> void:
	modulate.a *= 0.98
	position += Vector2.UP * speed
	speed *= 0.98


func _on_timer_timeout():
	queue_free()
