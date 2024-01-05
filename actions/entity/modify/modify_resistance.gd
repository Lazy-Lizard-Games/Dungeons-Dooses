extends ModifyEntity
class_name ModifyResistance

## Damage type to be modified.
@export var type: Enums.DamageType
## Resistance type to be modified.
@export var resistance: Enums.ResistanceType


func execute(entity: Entity) -> void:
	if condition:
		if !condition.execute(entity):
			return
	var resistances = entity.resistances
	match resistance:
		Enums.ResistanceType.Damage:
			resistances.modify_damage(type, modifier, is_add)
		Enums.ResistanceType.Duration:
			resistances.modify_duration(type, modifier, is_add)
		_:
			pass
	
