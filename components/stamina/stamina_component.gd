extends Node
class_name StaminaComponent

## Triggered when stamina fully regenerates from zero.
signal recovered
## Triggered when stamina reaches zero and not already exhausted.
signal exhausted
signal stamina_updated(previous: float, current: float)
signal maximum_updated(previous: Attribute, current: Attribute)

## Maximum stamina.
@export var maximum: Attribute:
	set(a):
		var prev = maximum
		maximum = a
		maximum_updated.emit(prev, maximum)
## ## Regeneration of stamina.
@export var regeneration: Attribute
## Current stamina.
@onready var current: float:
	set(h):
		previous = current
		current = clamp(h, 0, maximum.get_final_value())
		stamina_updated.emit(previous, current)
		if current == 0:
			is_exhausted = true
			exhausted.emit()
		if current == maximum.get_final_value():
			is_exhausted = false
			recovered.emit()
## Previous health.
@onready var previous := current
## Attributes of the parent object, if any.
var attributes: GenericAttributes:
	set(generics):
		attributes = generics
		var _maximum = attributes.get_generic(Enums.GenericType.StaminaMax)
		if _maximum:
			maximum = _maximum
		var _regeneration = attributes.get_generic(Enums.GenericType.StaminaRegeneration)
		if _regeneration:
			regeneration = _regeneration
		current = maximum.get_final_value()
## Stamina run out and recovering.
var is_exhausted := false

## Removes the amount from the current stamina.
func exhaust(amount: float) -> void:
	current -= amount

## Adds the amount to the current stamina.
func recover(amount: float) -> void:
	current += amount

func _process(delta):
	if current < maximum.get_final_value():
		current += regeneration.get_final_value() * delta
