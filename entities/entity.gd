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
## Action component for the entity.
@export var action_component: ActionComponent
## Generic attributes for the entity.
@export var generics: GenericAttributes = GenericAttributes.new()
## Affinity attribtues for the entity.
@export var affinities: AffinityAttributes = AffinityAttributes.new()
## Resistance attributes for the entity.
@export var resistances: ResistanceAttributes = ResistanceAttributes.new()
## Off sets the "position" of the entity. (for use with position vector action)
@export var position_offset: Vector2 = Vector2.ZERO
## Direction the entity is looking
var looking_at := Vector2.RIGHT
## Controls attack inputs
var can_attack := true

func _ready() -> void:
	z_index = 1
	generics = generics.duplicate(true)
	affinities = affinities.duplicate(true)
	resistances = resistances.duplicate(true)
	velocity_component.generics = generics
	hit.connect(on_hit)
	hurt.connect(on_hurt)
	kill.connect(on_kill)
	died.connect(on_died)

func on_hit(entity: Entity) -> void:
	var scale_factor = action_component.actor_on_hit_scale.get_final_value() * entity.action_component.target_on_hit_scale.get_final_value()
	for action in action_component.actions_on_hit:
		action.execute(entity, self, scale_factor)

func on_hurt(entity: Entity) -> void:
	var scale_factor = action_component.actor_on_hurt_scale.get_final_value() * entity.action_component.target_on_hurt_scale.get_final_value()
	for action in action_component.actions_on_hurt:
		action.execute(self, entity, scale_factor)

func on_kill(_entity: Entity) -> void:
	for action in action_component.actions_on_kill:
		action.execute(self, action_component.on_kill_scale.get_final_value())

func on_died() -> void:
	for action in action_component.actions_on_died:
		action.execute(self, action_component.on_died_scale.get_final_value())

func get_copy() -> Entity:
	var copy = Entity.new()
	copy.id = id
	copy.faction = faction
	copy.generics = generics
	copy.affinities = affinities
	copy.resistances = resistances
	copy.velocity_component = VelocityComponent.new()
	copy.action_component = ActionComponent.new()
	return copy

func enable_attack() -> void:
	can_attack = true

func disable_attack() -> void:
	can_attack = false
