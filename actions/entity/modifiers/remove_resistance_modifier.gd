extends EntityAction
class_name RemoveResistanceModifierEntityAction

## Removes a modifier from a resistance attribute.

## Attribute modifier to remove from resistance attribute.
@export var uid: String
## Resistance type.
@export var resistance_type: Enums.ResistanceType
## Damage type.
@export var damage_type: Enums.DamageType


func execute(entity: Entity, _scale := 1.0) -> void:
	entity.resistances.remove_modifier(resistance_type, damage_type, uid)
