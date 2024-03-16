class_name Effect
extends Node

## Describes the generic properties of an effect.

signal expired

## Unique identifier for the effect.
@export var uid: StringName
## Duration of the effect.
@export var duration: float
## Maximum stacks of the effect.
@export var max_stacks: int
var duration_timer: Timer
var entity: Entity
var stacks: int

## Initialises the effect with the affected entity.
func init(entity_in: Entity) -> void:
  entity = entity_in
  stacks = 1

## Adds a stack to the effect and restarts the timer.
func add_stack() -> void:
  stacks = clamp(stacks + 1, 0, max_stacks)
  duration_timer.start(duration)

## Applies the effect to the entity.
func enter() -> void:
  pass

## Removes the effect from the entity.
func exit() -> void:
  pass

func _ready() -> void:
  duration_timer = Timer.new()
  add_child(duration_timer)
  duration_timer.timeout.connect(on_duration_timout)
  duration_timer.start(duration)
  enter()

func on_duration_timout() -> void:
  stacks -= 1
  if stacks == 0:
    exit()
    expired.emit()