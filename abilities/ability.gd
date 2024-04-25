class_name Ability
extends State

## Takes control of an entity or other, and performs some unique action using them.

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

## The group organises the ability into separate sets of abilities.
@export var group: Enums.AbilityGroup
## The type controls which slots the ability may be equipped in for players.
@export var type: Enums.AbilityType
## A short description of what the ability does.
@export_multiline var description: String
## An icon for rendering the ability in UI.
@export var icon: Texture2D
## Minimum stamina required to start this ability.
@export var cost: int
## The time in seconds taken to charge the ability.
@export var charging_time: int
## The time in seconds taken to cast the ability.
@export var casting_time: int
## The time in seconds taken to refresh the ability
@export var refreshing_time: int

## The abilities current state.
var state: Enums.AbilityState = Enums.AbilityState.Ready
## Counter used for timing the charging.
var charging_timer: int = 0
## Counter used for timing the casting.
var casting_timer: int = 0
## Counter used for timing the refreshing.
var refreshing_timer: int = 0

## Sets the the ability as charging.
func charge() -> void:
	state = Enums.AbilityState.Charging
	charging.emit()

## Sets the ability as casting.
func cast() -> void:
	state = Enums.AbilityState.Casting
	casting.emit()

## Sets the ability as refreshing.
func refresh() -> void:
	state = Enums.AbilityState.Refreshing
	refreshing.emit()

func ready() -> void:
	state = Enums.AbilityState.Ready
	readied.emit()

func _process(delta):
	match state:
		Enums.AbilityState.Charging:
			charging_timer += delta * entity.generics.charge_speed
			if charging_timer > charging_time:
				charged.emit()
				charging_timer = 0
		Enums.AbilityState.Casting:
			casting_timer += delta * entity.generics.cast_speed
			if casting_timer > casting_time:
				casted.emit()
				casting_timer = 0
		Enums.AbilityState.Refreshing:
			refreshing_timer += delta * entity.generics.refresh_rate
			if refreshing_timer > refreshing_time:
				refreshed.emit()
				refreshing_timer = 0