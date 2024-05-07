extends Node
class_name ActionComponent

## Stores actions that are to be executed depending on trigger.

@export_group("On hit")
## Stores actions triggered when self is hit by an entity.
@export var actions_on_hit: Array[BientityAction]
## Scales on hit actions when actor.
@export var actor_on_hit_scale := Attribute.new(1)
## Scales on hit actions when target.
@export var target_on_hit_scale := Attribute.new(1)

@export_group("On hurt")
## Stores actions triggered when an entity is hit by self.
@export var actions_on_hurt: Array[BientityAction]
## Scales on hurt actions when actor.
@export var actor_on_hurt_scale := Attribute.new(1)
## Scales on hurt actions when target.
@export var target_on_hurt_scale := Attribute.new(1)

@export_group("On kill")
## Stores actions triggered on self when self dies.
@export var actions_on_kill: Array[EntityAction]
## Scales actions when actor.
@export var on_kill_scale := Attribute.new(1)

@export_group("On Died")
## Stores actions triggered on self when hurt entity dies.
@export var actions_on_died: Array[EntityAction]
## Scales actions when actor.
@export var on_died_scale := Attribute.new(1)
