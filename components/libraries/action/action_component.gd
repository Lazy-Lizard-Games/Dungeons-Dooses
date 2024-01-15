extends Node
class_name ActionComponent

signal resource_added(resource: StackingBientityResource)
signal resource_removed(resource: StackingBientityResource)

## Stores actions that are to be executed depending on trigger.

## Stores actions triggered when self is hit by an entity.
## The actor would be the entity and the target would be the self.
@export var actions_on_hit: Array[BientityAction]
## Stores actions triggered when an entity is hit by self.
## The actor would be the self and the target would be the entity.
@export var actions_on_hurt: Array[BientityAction]
## Stores actions triggered on self when self dies.
@export var actions_on_kill: Array[EntityAction]
## Stores actions triggered on self when hurt entity dies.
@export var actions_on_died: Array[EntityAction]

## Stacking resources currently attached to entity.
var resources: Array[StackingBientityResource]


func add_resource(resource: StackingBientityResource) -> void:
	resources.append(resource)
	resource_added.emit(resource)


func remove_resource(resource: StackingBientityResource) -> void:
	if resources.has(resource):
		resources.erase(resource)
		resource_removed.emit(resource)
