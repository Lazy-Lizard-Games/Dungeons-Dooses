extends EntityAction
class_name AddResistanceModifierEntityAction

## Adds a modifier to a resistance attribute.

## Attribute modifier to modify resistance by.
@export var modifier: AttributeModifier
## Resistance type to modify.
@export var resistance_type: Enums.ResistanceType
## Damage type of resistance.
@export var damage_type: Enums.DamageType


func execute(entity: Entity, _scale := 1.0) -> void:
	entity.resistances.add_modifier(resistance_type, damage_type, modifier)


func reverse(entity: Entity) -> void:
	var remove_resistance = RemoveResistanceModifierEntityAction.new()
	remove_resistance.uid = modifier.uid
	remove_resistance.resistance_type = resistance_type
	remove_resistance.damage_type = damage_type
	remove_resistance.execute(entity)
