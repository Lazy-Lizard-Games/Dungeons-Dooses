extends Character

const THROW_FORCE: int = 10

## Player's inventory data
@export var inventory_data: InventoryData

## Player's equipment data
@export var equipment_data: InventoryData

## Player's reach for interaction
@export var reach: int = 100

@onready var interact_area: Area2D = $InteractArea
@onready var interact_label: Label = $UI/Interactions/InteractLabel
@onready var interact_hover: TextureRect = $UI/Interactions/InteractHover
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var holster_a = $Back/HolsterA
@onready var holster_b = $Back/HolsterB

signal toggle_inventory
signal swap_weapon(index: int)

var armours: Array[ArmourData] = []
var weapons: Array[WeaponData] = [null, null, null]
var held_index = 0
var speed = get_stat("speed") * get_stat("speed_mult")

func init_setup() -> void:
	equipment_data.inventory_updated.connect(on_equipment_updated)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
	
	if Input.is_action_just_pressed("interract"):
		if interact_area.has_overlapping_bodies():
			var interactable = interact_area.get_overlapping_bodies()[0]
			if global_position.distance_to(interactable.global_position) <= reach:
				interactable.player_interact()
	
	if Input.is_action_just_pressed("primary"):
		if weapons[held_index]:
			weapons[held_index].primary()
	
	if Input.is_action_just_pressed("secondary"):
		if weapons[held_index]:
			weapons[held_index].secondary()
	
	if Input.is_action_just_pressed("scroll_up"):
		swap_held_weapon(-1)
	
	if Input.is_action_just_pressed("scroll_down"):
		swap_held_weapon(1)

func _physics_process(delta) -> void:
	# Update interract area
	interact_area.global_position = get_global_mouse_position()
	interact_label.hide()
	if interact_area.has_overlapping_bodies():
		var interactable = interact_area.get_overlapping_bodies()[0]
		interact_label.text = interactable._name
		# Center label below cursor
		interact_label.global_position = get_viewport().get_mouse_position()
		interact_label.global_position += Vector2(-interact_label.get_rect().size.x/2, 10)
		interact_label.show()
	
	# Get the input direction and handle the movement/deceleration.
	speed = get_stat("speed") * get_stat("speed_mult")
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction:
		if direction.x > 0:
			animated_sprite.flip_h = false
		elif direction.x < 0:
			animated_sprite.flip_h = true
		animated_sprite.play("walk")
		velocity = direction * speed
	else:
		animated_sprite.play("idle")
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()

func on_equipment_updated(equipment_data: InventoryData) -> void:
	# Reset equipment buffs/nerfs and revaluate
	# Inventory uses a fixed size of 6 right now
	# 1-4 is armour
	# 5-6 is weapon
	var equipment: Array[SlotData] = equipment_data.slot_datas
	print(equipment)
	equip_armours(equipment.slice(0, 4))
	equip_weapons(equipment.slice(4, 6))
	
	print("||------------------------------||")
	for stat in stats:
		print("%s: %s" % [stat, stats[stat]])
	print("Weapon A: %s" % weapons[0].name if weapons[0] else "Weapon A: ...")
	print("Weapon B: %s" % weapons[1].name if weapons[1] else "Weapon B: ...")

func equip_armours(equipment: Array[SlotData]) -> void:
	for item in equipment:
		if item:
			equip(item.item_data)

func equip(armour: ArmourData) -> void:
	mod_stat("defence", armour.defence)
	for sm in armour.stat_modifiers:
		mod_stat(sm.get_stat(), sm.get_value())
	for dm in armour.damage_modifiers:
		mod_damage_mult(dm.get_stat(), dm.get_value())
	for rm in armour.resist_modifiers:
		mod_damage_resist(rm.get_stat(), rm.get_value())

func equip_weapons(equipment: Array[SlotData]) -> void:
	weapons[0] = null
	for child in holster_a.get_children():
		holster_a.remove_child(child)
	if equipment[0]:
		weapons[0] = equipment[0].item_data
		holster_a.add_child(Globals.create_weapon(weapons[0]))
	weapons[1] = null
	for child in holster_b.get_children():
		holster_b.remove_child(child)
	if equipment[1]:
		weapons[1] = equipment[1].item_data
		holster_b.add_child(Globals.create_weapon(weapons[1]))

func swap_held_weapon(offset: int) -> void:
	held_index = held_index+offset
	if held_index < 0:
		held_index = 2
	held_index = held_index%3
	swap_weapon.emit(held_index)
