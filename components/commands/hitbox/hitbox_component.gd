extends Area2D
class_name HitboxComponent

signal hit(actor: Entity)

## Entity that hitbox belongs to.
@export var entity: Entity
## Toggles whether hitbox can trigger `hit` events.
@export var detect_only := false
## Duration of invulnerability after being hit, 0 if none.
@export var invulnerability_duration: float

# Invulnerability Shtuff
#invulnerable_timer = Timer.new()
	#invulnerable_timer.timeout.connect(
		#func():
			#invulnerable = false
	#)
	#add_child(invulnerable_timer)
	#if invulnerability_duration > 0:
		#invulnerable = true
		#invulnerable_timer.start(invulnerability_duration)

func _ready():
	var invulnerability_timer = Timer.new()
	invulnerability_timer.timeout.connect(
		func():
			detect_only = false
	)
	add_child(invulnerability_timer)
	hit.connect(
		func(_actor: Entity):
			detect_only = true
			invulnerability_timer.start(invulnerability_duration)
	)
