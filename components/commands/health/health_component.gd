extends Node
class_name HealthComponent

## Triggered when health reaches 0.
signal died(amount: float, source: Entity)
signal damaged(damage_data: DamageData, source: Entity)
signal updated(previous: float, current: float)
signal max_updated(previous: Attribute, current: Attribute)

## Immunity to all damage.
@export var invulnerable := false
## Max health if attributes not attached or no health attribute found.
@export var max: Attribute:
	set(a):
		var prev = max
		max = a
		max_updated.emit(prev, max)
## Health regen if attributes not attached or no health regen attribute found.
@export var regeneration: Attribute
## Current health.
@onready var current : float:
	set(h):
		previous = current
		current = clamp(h, 0, max.get_final_value())
		updated.emit(previous, current)
## Previous health.
@onready var previous := current
## Attributes of the parent object, if any.
var attributes: GenericAttributes:
	set(generics):
		attributes = generics
		var _max = attributes.get_generic(Enums.GenericType.HealthMax)
		if _max:
			max = _max
		var _regeneration = attributes.get_generic(Enums.GenericType.HealthRegeneration)
		if _regeneration:
			regeneration = _regeneration
		current = max.get_final_value()
## Checks whether the entity is dead or alive
var is_dead := false:
	get:
		return current == 0


func _ready():
	max = Attribute.new() if !max else max
	regeneration = Attribute.new() if !regeneration else regeneration


## Deals damage to the current health.
func damage(type: Enums.DamageType, amount: float, source: Entity) -> void:
	if is_dead or invulnerable:
		return
	#if attributes:
		#var resist = attributes.get_by_type()
	current -= amount
	if current == 0:
		died.emit(amount, source)


## Restores amount to the current health.
func heal(amount: float) -> void:
	current += amount
