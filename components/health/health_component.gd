extends Node
class_name HealthComponent

## Triggered when health reaches 0.
signal died
signal updated(previous: float, current: float)
signal maximum_updated(previous: Attribute, current: Attribute)

## Immunity to all damage.
@export var invulnerable := false
## Maximum health if attributes not attached or no health attribute found.
@export var maximum: Attribute:
	set(a):
		var prev = maximum
		maximum = a
		maximum_updated.emit(prev, maximum)
## Health regen if attributes not attached or no health regen attribute found.
@export var regeneration: Attribute
## Current health.
@onready var current: float:
	set(h):
		previous = current
		current = clamp(h, 0, maximum.get_final_value())
		updated.emit(previous, current)
## Previous health.
@onready var previous := current
## Attributes of the parent object, if any.
var attributes: GenericAttributes:
	set(generics):
		attributes = generics
		var _maximum = attributes.get_generic(Enums.GenericType.HealthMax)
		if _maximum:
			maximum = _maximum
		var _regeneration = attributes.get_generic(Enums.GenericType.HealthRegeneration)
		if _regeneration:
			regeneration = _regeneration
		current = maximum.get_final_value()
## Checks whether the entity is dead or alive
var is_dead := false:
	get:
		return current == 0

func _ready():
	maximum = Attribute.new() if !maximum else maximum
	regeneration = Attribute.new() if !regeneration else regeneration

func _process(delta):
	if current < maximum.get_final_value():
		current += regeneration.get_final_value() * delta

## Deals damage to the current health.
func damage(_type: Enums.DamageType, amount: float) -> void:
	if is_dead or invulnerable:
		return
	current -= amount
	if current == 0:
		died.emit()

## Restores amount to the current health.
func heal(amount: float) -> void:
	current += amount
