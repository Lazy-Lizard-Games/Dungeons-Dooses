extends Node2D
class_name EffectComponent

## Attribute component for attribute affecting effects.
@export var attribute: GenericAttributes
## Velocity component for effects that can manipulate control or friction.
@export var velocity: VelocityComponent
## Hurtbox component for effects that can hurt others.
@export var hurtbox: HurtboxComponent
## Health component for self damaging effects.
@export var health: HealthComponent


func add_effect(effect: Effect) -> void:
	for child in get_children() as Array[Effect]:
		if child.id != effect.id:
			continue
		child.add_stack()
		return
	add_child(effect)
	effect.expired.connect(func(): remove_effect(effect))
	effect.start(self)


func remove_effect(effect: Effect) -> void:
	for child in get_children() as Array[Effect]:
		if child != effect:
			continue
		remove_child(child)
		child.exit()


func get_effect(effect: Effect) -> Effect:
	for child in get_children() as Array[Effect]:
		if child != effect:
			continue
		return child
	return null
