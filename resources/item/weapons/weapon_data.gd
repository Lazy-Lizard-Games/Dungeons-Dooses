extends ItemData
class_name WeaponData

@export var attack_damage = 10
@export var attack_rate = 2

func setup() -> void:
	item_type = Globals.ITEM_TYPES.WEAPON
	item_card = preload("res://scenes/inventory/info_cards/weapon_card.tscn")
