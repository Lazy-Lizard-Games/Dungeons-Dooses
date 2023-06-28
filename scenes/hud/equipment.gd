extends Control

@onready var weapon_a: PanelContainer = $MarginContainer/WeaponContainer/WeaponA
@onready var weapon_b: PanelContainer = $MarginContainer/WeaponContainer/WeaponB

func on_equipment_updated(equipment_data: InventoryData):
	var slot_datas = equipment_data.slot_datas
	# Check for Weapon A
	if slot_datas[4]:
		weapon_a.set_slot_data(slot_datas[4])
	else:
		weapon_a.clear_slot_data()
	# Check for Weapon B
	if slot_datas[5]:
		weapon_b.set_slot_data(slot_datas[5])
	else:
		weapon_b.clear_slot_data()

func swap_weapon(index: int):
	match index:
		0:
			if weapon_a.item_data:
				set_weapon(weapon_a.item_data)
			else:
				print("The rum is gone!")
		1:
			if weapon_b.item_data:
				set_weapon(weapon_b.item_data)
			else:
				print("Why is the rum gone?")
		_:
			clear_weapon()

func set_weapon(weapon: WeaponData) -> void:
	print("Ah! The mighty %s!" % weapon.name)
	pass

func clear_weapon() -> void:
	print("Fists of fury!")
	pass
