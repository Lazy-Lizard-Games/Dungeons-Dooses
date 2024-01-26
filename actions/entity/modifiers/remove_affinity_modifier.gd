extends EntityAction
class_name RemoveAffinityModifierEntityAction

## Removes a modifier from a generic attribute.

## Attribute modifier to to remove from affinity attribute.
@export var uid: String
## Affinity type.
@export var affinity_type: Enums.AffinityType
## Damage type.
@export var damage_type: Enums.DamageType


func execute(entity: Entity, _scale := 1.0) -> void:
	entity.affinities.remove_modifier(affinity_type, damage_type, uid)
