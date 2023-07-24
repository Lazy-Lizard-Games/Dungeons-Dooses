extends ItemData
class_name WeaponData

@export var weapon_type: Globals.WEAPON_TYPES
@export var damage_data: DamageData
@export var primary_ability: AbilityData
@export var secondary_ability: AbilityData
@export var tertiary_ability: AbilityData

func setup() -> void:
	item_type = Globals.ITEM_TYPES.WEAPON
	item_card = preload("res://scenes/inventory/info_cards/weapon_card.tscn")

func get_damage_data() -> DamageData:
	var damage = damage_data.copy()
	return damage
