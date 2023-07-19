extends ItemData
class_name WeaponData

@export var attack_damage: float = 10
@export var attack_rate: float = 2
@export var primary_attack: AttackData
@export var secondary_attack: AttackData

func setup() -> void:
	item_type = Globals.ITEM_TYPES.WEAPON
	item_card = preload("res://scenes/inventory/info_cards/weapon_card.tscn")
