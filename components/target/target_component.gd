class_name TargetComponent
extends Area2D

## This component allows the entity to be hunted.

## Threat determines how much presence the target has.
@export var threat: int = 1
## The faction controls who can hunt this target.
@export var faction: Enums.FactionType

## Prevent the target from being detected.
func vanish() -> void:
	monitorable = false

## Allow the target to be detected.
func appear() -> void:
	monitorable = true