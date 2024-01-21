extends Area2D
class_name TargetComponent

signal target_updated(target: Entity)

## Owner of the target component.
var entity: Entity
## Current target of the target component.
var current_target: Entity:
	set(new_target):
		current_target = new_target
		target_updated.emit(current_target)


func _physics_process(_delta):
	if !current_target:
		for body in get_overlapping_bodies():
			if body is Entity:
				if body == entity or body.faction == entity.faction:
					continue
				current_target = body
	else:
		if !current_target in get_overlapping_bodies():
			current_target = null
