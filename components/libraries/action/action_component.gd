extends Node
class_name ActionComponent

signal effects_updated

## Stores actions that are to be executed depending on trigger.

## Stores actions triggered when self is hit by an entity.
## The actor would be the entity and the target would be the self.
@export var actions_on_hit: Array[BientityAction]
## Stores actions triggered when an entity is hit by self.
## The actor would be the self and the target would be the entity.
@export var actions_on_hurt: Array[BientityAction]

## Stacking resources currently attached to entity.
@export var resources: Array[StackingResource]
