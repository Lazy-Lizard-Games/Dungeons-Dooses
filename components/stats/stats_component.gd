extends Node
class_name StatsComponent

@export_category("Health")
## The base maximum health of the entity.
@export var max_health := 10.0:
	get:
		return max_health * health_modifier
## How much the max health should be modified before being used.
@export var health_modifier := 1.0

@export_category("Movement")
## The top speed possible for the entity.
@export var max_speed := 100.0:
	get:
		return max_speed * speed_modifier
## How much the max speed is modified before using.
@export var speed_modifier := 1.0
## How quickly it will reach top speed.
@export var acceleration := 25.0:
	get:
		return acceleration * acceleration_modifier
## How much the acceleration is modified before using.
@export var acceleration_modifier := 1.0
## How quickly it will slow down when not moving.
@export_range(0, 1) var friction := 0.5
## How much impact knockback has on the entity.
@export_range(0, 1) var knockback_resist := 0.5
## Toggle whether to ignore knockback, usually temporary.
@export var ignore_knockback := false

@export_category("Resistances")
@export var normal_resistance := 0.0
@export var fire_resistance := 0.0
@export var frost_resistance := 0.0
@export var shock_resistance := 0.0
@export var poison_resistance := 0.0

@export_category("Modifiers")
@export var normal_modifier := 1.0
@export var fire_modifier := 1.0
@export var frost_modifier := 1.0
@export var shock_modifier := 1.0
@export var poison_modifier := 1.0


## Returns the resistance value for the given type.
func get_resistance(type: Globals.DAMAGE) -> float:
	match type:
		Globals.DAMAGE.NORMAL:
			return normal_resistance
		Globals.DAMAGE.FIRE:
			return fire_resistance
		Globals.DAMAGE.FROST:
			return frost_resistance
		Globals.DAMAGE.SHOCK:
			return shock_resistance
		Globals.DAMAGE.POISON:
			return poison_resistance
		_:
			return 0


## Sets the resistance value for the given type to the new value.
func set_resistance(type: Globals.DAMAGE, resistance: float) -> void:
	match type:
		Globals.DAMAGE.NORMAL:
			normal_resistance = resistance
		Globals.DAMAGE.FIRE:
			fire_resistance = resistance
		Globals.DAMAGE.FROST:
			frost_resistance = resistance
		Globals.DAMAGE.SHOCK:
			shock_resistance = resistance
		Globals.DAMAGE.POISON:
			poison_resistance = resistance


## Returns the modifier value for the given type.
func get_modifier(type: Globals.DAMAGE) -> float:
	match type:
		Globals.DAMAGE.NORMAL:
			return normal_modifier
		Globals.DAMAGE.FIRE:
			return fire_modifier
		Globals.DAMAGE.FROST:
			return frost_modifier
		Globals.DAMAGE.SHOCK:
			return shock_modifier
		Globals.DAMAGE.POISON:
			return poison_modifier
		_:
			return 0


## Sets the modifier value for the given type to the new value.
func set_modifier(type: Globals.DAMAGE, modifier: float) -> void:
	match type:
		Globals.DAMAGE.NORMAL:
			normal_modifier = modifier
		Globals.DAMAGE.FIRE:
			fire_modifier = modifier
		Globals.DAMAGE.FROST:
			frost_modifier = modifier
		Globals.DAMAGE.SHOCK:
			shock_modifier = modifier
		Globals.DAMAGE.POISON:
			poison_modifier = modifier
