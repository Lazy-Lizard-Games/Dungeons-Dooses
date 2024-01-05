extends CharacterBody2D
class_name Entity

## Entities are objects that can interact with the world through a variety of ways.

## Triggered when hit.
signal hit(actor: Entity)
## Triggered on hit.
signal hurt(target: Entity)
## Triggered on item pickup.
signal pickup(actor: Entity, item: int)
## Triggered on item consume.
signal consume(actor: Entity, item: int)

## Identifying name for the entity.
@export var id: String = ""
## Faction of the entity.
@export var faction: Enums.FactionType = Enums.FactionType.None
## Velocity component for the entity.
@export var velocity_component: VelocityComponent
## Action component for the entity.
@export var action_component: ActionComponent
## Generic attributes for the entity.
@export var generics: GenericAttributes = GenericAttributes.new()
## Affinity attribtues for the entity.
@export var affinities: AffinityAttributes = AffinityAttributes.new()
## Resistance attributes for the entity.
@export var resistances: ResistanceAttributes = ResistanceAttributes.new()


func _ready() -> void:
	generics = generics.duplicate(true)
	affinities = affinities.duplicate(true)
	resistances = resistances.duplicate(true)
	velocity_component.generics = generics
	hit.connect(on_hit)
	hurt.connect(on_hurt)


func on_hit(actor: Entity) -> void:
	for action in action_component.actions_on_hit:
		action.execute(actor, self)


func on_hurt(target: Entity) -> void:
	for action in action_component.actions_on_hurt:
		action.execute(self, target)
