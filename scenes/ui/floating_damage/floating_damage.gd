extends Marker2D
class_name DamageFloat

@export var damage_colors: DamageColourSet

@onready var label: Label = $Label
@onready var timer: Timer = $Timer

var type: Globals.DAMAGE_TYPES = Globals.DAMAGE_TYPES.PHYSICAL
var damage: float = 0
var speed: float = 1
var gravity: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.UP


func init(t: Globals.DAMAGE_TYPES, d: float, s: float):
	type = t
	damage = d
	speed = s

func _ready() -> void:
	top_level = true
	timer.wait_time = randf_range(1, 1.5)
	direction = direction.rotated(deg_to_rad(randf_range(-10, 10))).normalized()
	label.text = "%.1f" % damage if damage < 1.0 else "%s" % damage
	label["theme_override_colors/font_color"] = get_color(type)
	timer.start()

func _process(delta: float) -> void:
	direction += gravity * delta
	global_position += direction * speed


func get_color(damage_type: Globals.DAMAGE_TYPES) -> Color:
	match damage_type:
		Globals.DAMAGE_TYPES.PHYSICAL:
			return damage_colors.physical
		Globals.DAMAGE_TYPES.FIRE:
			return damage_colors.fire
		Globals.DAMAGE_TYPES.FROST:
			return damage_colors.frost
		Globals.DAMAGE_TYPES.POISON:
			return damage_colors.poison
		Globals.DAMAGE_TYPES.SHOCK:
			return damage_colors.shock
		Globals.DAMAGE_TYPES.EXPLOSION:
			return damage_colors.explosion
		Globals.DAMAGE_TYPES.LIGHT:
			return damage_colors.light
		_:
			return Color.WHITE

func _on_timer_timeout() -> void:
	queue_free()
