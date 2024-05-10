class_name Ability
extends State

## Takes control of an entity or other, and performs some unique action using them.

enum AbilityState
{
	Ready,
	Charging,
	Casting,
	Refreshing,
}

## Emitted when an ability starts charging.
signal charging
## Emitted when an ability finishes charging.
signal charged
## Emitted when the ability has started casting.
signal casting
## Emitted when the ability has finished casting.
signal casted
## Emitted when the ability has stared refreshing.
signal refreshing
## Emitted when the ability has finished refreshing.
signal refreshed
## Emitted when the abilty has failed to start.
signal failed
## Emitted when the ability is ready again.
signal readied

## The type controls which slots the ability may be equipped in for players.
@export var type: Enums.AbilityType
## A short description of what the ability does.
@export_multiline var description: String
## An icon for rendering the ability in UI.
@export var icon: Texture2D
## Minimum stamina required to start this ability.
@export var cost: int
## The time in seconds taken to charge the ability.
@export var charging_time: float
## The time in seconds taken to cast the ability.
@export var casting_time: float
## The time in seconds taken to refresh the ability
@export var refreshing_time: float

## The abilities current state.
var state: AbilityState = AbilityState.Ready
## Counter used for timing the charging.
var charging_timer: float = 0
## Counter used for timing the casting.
var casting_timer: float = 0
## Counter used for timing the refreshing.
var refreshing_timer: float = 0

## Sets the the ability as charging.
func charge() -> void:
	charging_timer = 0
	state = AbilityState.Charging
	charging.emit()

## Sets the ability as casting.
func cast() -> void:
	casting_timer = 0
	state = AbilityState.Casting
	casting.emit()

## Sets the ability as refreshing.
func refresh() -> void:
	refreshing_timer = 0
	state = AbilityState.Refreshing
	refreshing.emit()

func ready() -> void:
	state = AbilityState.Ready
	readied.emit()
