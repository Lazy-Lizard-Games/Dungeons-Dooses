extends Area2D
class_name HurtboxComponent

signal hurt(hitbox: HitboxComponent)

## Toggles the hurtbox to only hit a target once, even if they remain in the area.
@export var single_hit: bool
## Collection of already hit targets. For use with single hit hurtboxes.
var hit_targets: Array[HitboxComponent] = []


func on_area_collision(area: Area2D) -> void:
	if area is HitboxComponent:
		if area.detect_only:
			return
		if single_hit:
			if area in hit_targets:
				return
			hit_targets.append(area)
		hurt.emit(area)
