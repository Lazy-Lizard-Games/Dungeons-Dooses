extends Area2D
class_name HurtboxComponent

signal hurt(hitbox: HitboxComponent)


func on_area_collision(area: Area2D) -> void:
	if area is HitboxComponent:
		if area.detect_only:
			return
		hurt.emit(area)
