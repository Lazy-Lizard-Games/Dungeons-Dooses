extends ItemData
class_name WeaponData

@export var damage_data: DamageData
@export var primary_attack: AttackData
@export var secondary_attack: AttackData
@export var damage_modifiers: Array[DamageModifier]

func setup() -> void:
	item_type = Globals.ITEM_TYPES.WEAPON
	item_card = preload("res://scenes/inventory/info_cards/weapon_card.tscn")

func get_damage() -> DamageData:
	var damage = damage_data.copy()
	for dm in damage_modifiers:
		if dm.get_type() == damage.get_type():
			damage.mod_damage(dm.get_value())
	return damage
