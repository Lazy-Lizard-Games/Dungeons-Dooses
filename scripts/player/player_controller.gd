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

signal toggle_inventory

var weapon_a = null
var weapon_b = null
var armour = []
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
	reset_stats()
	var equipment: Array[SlotData] = equipment_data.slot_datas
	for item in equipment.slice(0, 4):
		if item:
			equip(item.item_data)
	weapon_a = null
	if equipment[4]:
		weapon_a = equipment[4].item_data
	weapon_b = null
	if equipment[5]:
		weapon_b = equipment[5].item_data
	
	print("||------------------------------||")
	for stat in stats:
		print("%s: %s" % [stat, stats[stat]])
	print("Weapon A: %s" % weapon_a.name if weapon_a else "Weapon A: ...")
	print("Weapon B: %s" % weapon_b.name if weapon_b else "Weapon B: ...")

func equip(armour: ArmourData):
	mod_stat("defence", armour.defence)
	for sm in armour.stat_modifiers:
		mod_stat(sm.get_stat(), sm.get_value())
	for dm in armour.damage_modifiers:
		mod_damage_mult(dm.get_stat(), dm.get_value())
	for rm in armour.resist_modifiers:
		mod_damage_resist(rm.get_stat(), rm.get_value())

