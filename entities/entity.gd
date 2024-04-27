extends CharacterBody2D
class_name Entity

## Entities are objects that can interact with the world through a variety of ways.

## Triggered when hit.
signal hit(entity: Entity)
## Triggered on hit.
signal hurt(entity: Entity)
## Triggered when hurt entity dies.
signal kill(entity: Entity)
## Triggered when self dies.
signal died
## Triggered on item pickup.
signal pickup(actor: Entity, item: int)
## Triggered on item consume.
signal consume(actor: Entity, item: int)

## Identifying name for the entity.
@export var id: String = ""
## Faction of the entity.
@export var faction: Enums.FactionType = Enums.FactionType.None
## Animation tree for animating the states of the entity.
@export var animation_tree: AnimationTree
## Velocity component for the entity.
@export var velocity_component: VelocityComponent
## Used to offset the entities position to match the sprite more accurately.
@export var position_offset: Vector2 = Vector2.ZERO
## The player's centre position found by adding `position_offset` to `global_position`.
var centre_position := Vector2.ZERO:
	get:
		return global_position + position_offset
## The direction to mouse position from the entity's `centre_position`.
var looking_at := Vector2.ZERO:
	get:
		return centre_position.direction_to(get_global_mouse_position())
