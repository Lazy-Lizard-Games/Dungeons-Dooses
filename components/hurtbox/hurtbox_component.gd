extends Area2D
class_name HurtboxComponent

signal entity_damaged(damage: DamageData, target: Entity)
signal entity_killed(damage: DamageData, target: Entity)

@export
var collision : CollisionData

@export
var rate := 0.0


func _ready() -> void:
	if rate > 0:
		var timer = Timer.new()
		add_child(timer)
		timer.timeout.connect(on_timeout)
		timer.one_shot = false
		timer.start(1.0/rate)
	else:
		area_entered.connect(on_area_collision)


func on_timeout() -> void:
	for area in get_overlapping_areas():
		on_area_collision(area)


func on_area_collision(area: Area2D) -> void:
	if area is HitboxComponent:
		area.handle_collision(collision, self)
