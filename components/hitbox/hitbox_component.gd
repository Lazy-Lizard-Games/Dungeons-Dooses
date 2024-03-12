extends Area2D
class_name HitboxComponent

signal hit(actor: Entity)

## Entity that hitbox belongs to.
@export var entity: Entity
## Toggles whether hitbox can trigger `hit` events.
@export var detect_only := false
## Duration of invulnerability after being hit, 0 if none.
@export var invulnerability_duration: float


func _ready():
	var invulnerability_timer = Timer.new()
	invulnerability_timer.timeout.connect(
		func():
			detect_only = false
			monitoring = true
			for area in get_overlapping_areas():
				if area is HurtboxComponent:
					area.on_area_collision(self)
					monitoring = false
					break
			monitoring = false
	)
	add_child(invulnerability_timer)
	hit.connect(
		func(_actor: Entity):
			detect_only = true
			invulnerability_timer.start(invulnerability_duration)
	)
