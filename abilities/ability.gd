class_name Ability
extends Node2D

signal started
signal casted
signal ended
signal recharged

## A human readable name for identifying the ability.
@export var uid: StringName
## A short description of what the ability does.
@export_multiline var description: String
## An icon for rendering the ability in UI.
@export var icon: Image
## Minimum stamina required to start this ability.
@export var cost: Number

var is_recharging := false
var is_casting := false
var caster: Entity

## Checks whether the entity can start this ability.
func can_start(entity: Entity) -> bool:
	if 'stamina_component' in entity:
		if entity.stamina_component.current < (cost.get_number() * entity.generics.get_generic(Enums.GenericType.AbilityEfficiency).get_final_value()):
			return false
	if is_recharging or is_casting:
		return false
	return true

## Starts the ability and the entity as the caster.
func start(entity: Entity) -> void:
	entity.looking_at = global_position.direction_to(get_global_mouse_position())
	if !can_start(entity):
		return
	started.emit()
	caster = entity
	cast()

## Casts the ability. Intended to be overridden.
func cast() -> void:
	casted.emit()
	recharge()

## Recharges the ability. Intended to be overridden.
func recharge() -> void:
	recharged.emit()
	end()

## Ends the ability.
func end() -> void:
	ended.emit()
	if !caster:
		return
	caster = null
