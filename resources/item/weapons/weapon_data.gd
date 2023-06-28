extends ItemData
class_name WeaponData

@export var attack_damage = 10
@export var attack_rate = 2

func setup() -> void:
	item_type = Globals.ITEM_TYPES.WEAPON
