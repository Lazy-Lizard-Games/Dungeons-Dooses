extends ModifyEntity
class_name ModifyAffinity

## Damage type to be modified.
@export var type: Enums.DamageType
## Affinity type to be modified.
@export var affinity: Enums.AffinityType


func execute(entity: Entity) -> void:
	if condition:
		if !condition.execute(entity):
			return
	var affinities = entity.affinities
	match affinity:
		Enums.AffinityType.Damage:
			affinities.modify_damage(type, modifier, is_add)
		Enums.AffinityType.Duration:
			affinities.modify_duration(type, modifier, is_add)
		_:
			pass
	
