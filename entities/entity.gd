extends CharacterBody2D
class_name Entity

## Entities are objects that can interact with the world through a variety of ways.

## Triggered on self hit.
signal hit(actor: Entity, target: Entity)
## Triggered on target hit.
signal hurt(actor: Entity, target: Entity)

## Identifying name for the entity.
@export var id := ""
## Faction of the entity.
@export var faction := Enums.FactionType.None
## Velocity component for the entity.
@export var velocity_component: VelocityComponent
## Action component for the entity.
@export var action_component: ActionComponent
## Generic attributes for the entity.
@export var generic_attributes: GenericAttributes


func _ready() -> void:
	velocity_component.attributes = generic_attributes
	hit.connect(on_hit)
	hurt.connect(on_hurt)


func on_hit(actor: Entity, target: Entity) -> void:
	for action in action_component.actions_on_hit:
		action.execute(actor, target)


func on_hurt(actor: Entity, target: Entity) -> void:
	for action in action_component.actions_on_hurt:
		action.execute(actor, target)
