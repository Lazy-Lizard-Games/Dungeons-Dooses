class_name Ability
extends State

## Takes control of an entity or other, and performs some unique action using them.

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

@export var stats: StatsComponent
## The type controls which slots the ability may be equipped in for players.
@export var type: Enums.AbilityType
## A short description of what the ability does.
@export_multiline var description: String
## An icon for rendering the ability in UI.
@export var icon: Texture2D
## Minimum stamina required to start this ability.
@export var cost: int
## The time in seconds taken to cast the ability.
@export var casting_time: float
## The time in seconds taken to refresh the ability
@export var refreshing_time: float

var is_ready := false
var is_casting := false
var is_refreshing := false
## Counter used for timing the casting.
var casting_timer: float = 0
## Counter used for timing the refreshing.
var refreshing_timer: float = 0

## Sets the ability as casting.
func cast() -> void:
	casting_timer = 0
	is_casting = true
	casting.emit()

## Sets the ability as refreshing.
func refresh() -> void:
	refreshing_timer = 0
	is_refreshing = true
	refreshing.emit()

func ready() -> void:
	is_ready = true
	readied.emit()

func process_casting_timer(delta: float) -> void:
	casting_timer += delta * stats.cast_rate.get_final_value()
	if casting_timer >= casting_time:
		casting_timer -= casting_time
		is_casting = false
		casted.emit()

func process_refreshing_timer(delta: float) -> void:
	refreshing_timer += delta * stats.refresh_rate.get_final_value()
	if refreshing_timer >= refreshing_time:
		refreshing_timer -= refreshing_time
		is_refreshing = false
		refreshed.emit()

func process_timers(delta: float) -> void:
	if is_casting:
		process_casting_timer(delta)
	if is_refreshing:
		process_refreshing_timer(delta)