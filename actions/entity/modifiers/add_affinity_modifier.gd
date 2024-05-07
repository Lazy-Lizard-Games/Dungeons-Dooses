extends EntityAction
class_name AddAffinityModifierEntityAction

## Adds a modifier to a generic attribute.

## Attribute modifier to modify affinity by.
@export var modifier: AttributeModifier
## Affinity type to modify.
@export var affinity_type: Enums.AffinityType
## Damage type of affinity.
@export var damage_type: Enums.DamageType


func execute(entity: Entity, _scale := 1.0) -> void:
	entity.affinities.add_modifier(affinity_type, damage_type, modifier)


func reverse(entity: Entity) -> void:
	var remove_affinity = RemoveAffinityModifierEntityAction.new()
	remove_affinity.uid = modifier.uid
	remove_affinity.affinity_type = affinity_type
	remove_affinity.damage_type = damage_type
	remove_affinity.execute(entity)
