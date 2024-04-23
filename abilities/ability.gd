class_name Ability
extends State

## Takes control of an entity or other, and performs some unique action using them.

## Emitted when an ability begins charging. 
signal started
## Emitted when an ability finishes charging.
signal charged
## Emitted when the ability has been casted.
signal casted
## Emitted when the abilty has failed to cast.
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

var state: Enums.AbilityState = Enums.AbilityState.Ready

## Starts the ability.
func start() -> void:
	state = Enums.AbilityState.Charging
	started.emit()

## Updates the abilities state being charged.
func charge() -> void:
	state = Enums.AbilityState.Casting
	charged.emit()

## Updates the abilities state for being casted.
func cast() -> void:
	state = Enums.AbilityState.Coodown
	casted.emit()

## Updates the abilities state being recharged.
func recharge() -> void:
	state = Enums.AbilityState.Ready
	recharged.emit()

## Ends the ability.
func end() -> void:
	ended.emit()
