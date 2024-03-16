extends Area2D
class_name HitboxComponent

signal hit(actor: Entity)

## Entity that hitbox belongs to.
@export var entity: Entity
## Toggles whether hitbox can trigger `hit` events.
@export var detect_only := false
## Duration of invulnerability after being hit, 0 if none.
@export var invulnerability_duration: float
var invulnerability_timer: Timer

func _ready():
	invulnerability_timer = Timer.new()
	invulnerability_timer.timeout.connect(on_invulnerability_timer_timeout)
	add_child(invulnerability_timer)

func hit_by(actor: Entity) -> void:
	detect_only = true
	invulnerability_timer.start(invulnerability_duration)
	hit.emit(actor)

func on_invulnerability_timer_timeout() -> void:
	detect_only = false
	monitoring = true
	for area in get_overlapping_areas():
		if area is HurtboxComponent:
			area.on_area_collision(self)
			monitoring = false
			break
	monitoring = false