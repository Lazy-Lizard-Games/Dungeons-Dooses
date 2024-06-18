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
	scale = Vector2(0.5, 0.5)
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'position', Vector2(self.position.x, self.position.y - 5), 0.25)
	tween.parallel().tween_property(self, 'scale', Vector2(1, 1), 0.35)
	tween.tween_property(self, 'scale', Vector2(0.25, 0.25), 0.35)
	tween.parallel().tween_property(self, 'modulate', Color(1,1,1,0), 0.35)
	tween.tween_callback(self.queue_free)

