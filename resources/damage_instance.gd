extends Resource
class_name DamageInstance

## Damage type of instance, e.g.: Fire, Shock, etc.
@export var damage_type: Globals.DAMAGE_TYPES
## Damage as percent of base damage, e.g.: 0.5 is 50% of base damage.
@export_range(0, 2) var percent_of_base: float = 1

func get_damage_data(base_damage: float) -> DamageData:
	var damage_data = DamageData.new()
	damage_data.type = damage_type
	damage_data.damage = base_damage * percent_of_base
	return damage_data
