extends Marker2D
class_name DamageFloat

@export var damage_colours: DamageColourSet

@onready var label: Label = $Label
@onready var timer: Timer = $Timer

var colour: Color = Color.ALICE_BLUE
var damage: float = 0
var speed: float = 1
var gravity: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.UP

func _ready() -> void:
	top_level = true
	timer.wait_time = randf_range(1, 1.5)
	speed = randf_range(2, 2.5)
	direction = direction.rotated(deg_to_rad(randf_range(-10, 10))).normalized()
	label.text = "%.1f" % damage if damage < 1.0 else "%s" % damage
	label["theme_override_colors/font_color"] = colour
	timer.start()

func _process(delta: float) -> void:
	direction += gravity * delta
	global_position += direction * speed


func get_colour(damage_type: Globals.DAMAGE_TYPES) -> Color:
	match damage_type:
		Globals.DAMAGE_TYPES.PHYSICAL:
			return damage_colours.physical
		Globals.DAMAGE_TYPES.FIRE:
			return damage_colours.fire
		Globals.DAMAGE_TYPES.FROST:
			return damage_colours.frost
		Globals.DAMAGE_TYPES.POISON:
			return damage_colours.poison
		Globals.DAMAGE_TYPES.SHOCK:
			return damage_colours.shock
		Globals.DAMAGE_TYPES.EXPLOSION:
			return damage_colours.explosion
		Globals.DAMAGE_TYPES.LIGHT:
			return damage_colours.light
		_:
			return colour

func _on_timer_timeout() -> void:
	queue_free()
