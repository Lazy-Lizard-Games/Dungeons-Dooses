class_name DamageIndicator
extends Node2D

@export var duration: float
@export var colors: DamageColorData
@export var label: Label

var speed = 100
var timer := 0.0
var direction = 0

func format_amount(amount: float) -> String:
	if amount < 1_000:
		return "%s" % amount
	elif amount < 1_000_000:
		return "%s K" % amount
	else:
		return "%s M" % amount

func load_damage_data(damage_data: DamageData) -> void:
	label['theme_override_colors/font_color'] = colors.getColorForType(damage_data.type)
	label.text = format_amount(damage_data.amount)
	label.position = Vector2((label.size.x / - 2.0), (label.size.y / - 2.0))

func _ready():
	direction = (0.5 - randf()) * 0.5

func _process(delta):
	scale *= 0.99
	position.y -= delta * speed * (log(timer + 1) / log(0.5) + 1)
	position.x += delta * speed * direction
	timer += delta
	if timer >= duration:
		queue_free()
