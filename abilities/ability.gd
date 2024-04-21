class_name Ability
extends Node2D

## Emitted when an ability is successfully started. 
signal started
## Emitted when the ability has succeeded to cast.
signal casted
## Emitted when the abilty has failde to cast.
signal failed
## Emitted when the ability has finished casting.
signal ended
## Emitted when the ability has finished recharging.
signal recharged

## The group organises the ability into separate sets of abilities.
@export var group: Enums.AbilityGroup
## The type controls which slots the ability may be equipped in for players.
@export var type: Enums.AbilityType
## A short description of what the ability does.
@export_multiline var description: String
## An icon for rendering the ability in UI.
@export var icon: Texture2D
## Minimum stamina required to start this ability.
@export var cost: Number
## The state of the ability which should control the entity
@export var state: State

var is_recharging := false
var is_casting := false
var entity: Entity

## Checks whether the entity can start this ability.
func can_start(entity_in: Entity) -> bool:
	if 'stamina_component' in entity_in:
		if entity_in.stamina_component.current < (cost.get_number() * entity_in.generics.get_generic(Enums.GenericType.AbilityEfficiency).get_final_value()):
			failed.emit()
			return false
	if is_recharging or is_casting:
		failed.emit()
		return false
	return true

## Starts the ability and the entity as the entity.
func start(entity_in: Entity) -> void:
	entity = entity_in
	state.entity = entity
	entity.looking_at = global_position.direction_to(get_global_mouse_position())
	started.emit()
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
