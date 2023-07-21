extends Character

const THROW_FORCE: int = 10

## Player's inventory data
@export var inventory_data: InventoryData

## Player's equipment data
@export var equipment_data: InventoryData

## Player's reach for interaction
@export var reach: int = 100

@onready var interact_area: Area2D = $InteractArea
@onready var interactions: VBoxContainer = $UI/Interactions
@onready var action_name: Label = $UI/Interactions/ActionName
@onready var interact_name: Label = $UI/Interactions/InteractName
@onready var sprites: Node2D = $Sprites
@onready var holster_a: Node2D = $Sprites/Back/HolsterA
@onready var holster_b: Node2D = $Sprites/Back/HolsterB
@onready var hand: Node2D = $Sprites/Hand
@onready var animator: AnimationPlayer = $Animator

signal toggle_inventory
signal swap_weapon(index: int)
signal primary_down
signal primary_up
signal secondary_down
signal secondary_up


var worn_armours: Array[ArmourData] = []
var worn_weapons: Array[WeaponData] = [null, null, null]
var holsters: Array[Node2D]
var held_index = 2
var old_index = 2
var holstered = false
var speed = get_stat("speed") * get_stat("speed_mult")
var attacking = false

func init_setup() -> void:
	holsters = [holster_a, holster_b]
	equipment_data.inventory_updated.connect(on_equipment_updated)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
	
	if Input.is_action_just_pressed("interact"):
		if interact_area.has_overlapping_bodies():
			var interactable = get_closest_body(interact_area.get_overlapping_bodies())
			interactable.interact(self)
	
	if Input.is_action_just_pressed("weapon_A"):
		if held_index != 0:
			holstered = false
			swap_held_weapon(0)
		else:
			holstered = true
			swap_held_weapon(2)
	
	if Input.is_action_just_pressed("weapon_B"):
		if held_index != 1:
			holstered = false
			swap_held_weapon(1)
		else:
			holstered = true
			swap_held_weapon(2)
	
	if Input.is_action_just_pressed("holster"):
		holstered = not holstered
		if holstered:
			swap_held_weapon(2)
		else:
			swap_held_weapon(old_index)
	
	if Input.is_action_just_pressed("primary"):
		primary_down.emit()
	
	if Input.is_action_just_released("primary"):
		primary_up.emit()
	
	if Input.is_action_just_pressed("secondary"):
		secondary_down.emit()
	
	if Input.is_action_just_released("secondary"):
		secondary_up.emit()

func _physics_process(delta) -> void:
	# Check if player is attacking
	if Input.is_action_pressed("primary") and not attacking:
		if hand.get_children():
			hand.get_child(0).primary()
	
	if Input.is_action_pressed("secondary") and not attacking:
		if hand.get_children():
			hand.get_child(0).secondary()
	
	# Update interract area
	interactions.hide()
	if interact_area.has_overlapping_bodies():
		var interactable = get_closest_body(interact_area.get_overlapping_bodies())
		action_name.text = interactable.get_action_name()
		interact_name.text = interactable.get_interact_name()
		interactions.position = interactable.position
		interactions.show()
	
	# Get the input direction and handle the movement/deceleration.
	speed = get_stat("speed") * get_stat("speed_mult")
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction:
		if direction.x > 0 and not attacking:
			sprites.scale.x = 1
		elif direction.x < 0 and not attacking:
			sprites.scale.x = -1
		animator.play("walk")
		velocity = direction * speed
	else:
		animator.play("idle")
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()

func on_equipment_updated(equipment_data: InventoryData) -> void:
	# Clear old equipment
	for child in hand.get_children():
		hand.remove_child(child)
	worn_armours.clear()
	# Fetch new equipment
	var equipment: Array[SlotData] = equipment_data.slot_datas
	# Equip new armours
	equip_armours(equipment.slice(0, 4))
	# Equip new weapons
	equip_weapons(equipment.slice(4, 6))
	# Update new stats
	update_stats()

func equip_armours(armours: Array[SlotData]) -> void:
	for armour in armours:
		if armour:
			equip_armour(armour.item_data)

func equip_armour(armour: ArmourData) -> void:
	worn_armours.append(armour)

func equip_weapons(weapons: Array[SlotData]) -> void:
	for i in weapons.size():
		equip_weapon(i, holsters[i], weapons[i])

func equip_weapon(index: int, holster: Node2D, weapon: SlotData) -> void:
	worn_weapons[index] = null
	for child in holster.get_children():
		holster.remove_child(child)
	if weapon:
		if held_index == index:
			swap_held_weapon(2)
		worn_weapons[index] = weapon.item_data
		holster.add_child(Globals.create_weapon(weapon.item_data, self))

func update_stats() -> void:
	reset_stats()
	apply_buffs()
	apply_armour_stats()

func apply_armour_stats() -> void:
	for armour in worn_armours:
		mod_stat("defence", armour.defence)
		for sm in armour.stat_modifiers:
			mod_stat(sm.get_stat(), sm.get_value())
		for dm in armour.damage_modifiers:
			mod_damage_mult(dm.get_stat(), dm.get_value())
		for rm in armour.resist_modifiers:
			mod_damage_resist(rm.get_stat(), rm.get_value())

func swap_held_weapon(index: int) -> void:
	if worn_weapons[held_index]:
		holster_weapon(held_index)
	old_index = held_index
	held_index = index
	swap_weapon.emit(held_index)
	if worn_weapons[held_index]:
		hold_weapon(held_index)

func hold_weapon(index) -> void:
	for child in holsters[index].get_children():
		holsters[index].remove_child(child)
	var weapon = Globals.create_weapon(worn_weapons[index], self)
	weapon.attack.connect(on_weapon_attack)
	weapon.idle.connect(on_weapon_idle)
	primary_down.connect(weapon.on_primary_down)
	primary_up.connect(weapon.on_primary_up)
	secondary_down.connect(weapon.on_secondary_down)
	secondary_up.connect(weapon.on_secondary_up)
	hand.add_child(weapon)
	attacking = false

func holster_weapon(index) -> void:
	for child in hand.get_children():
		child.attack.disconnect(on_weapon_attack)
		child.idle.disconnect(on_weapon_idle)
		primary_down.disconnect(child.on_primary_down)
		primary_up.disconnect(child.on_primary_up)
		secondary_down.disconnect(child.on_secondary_down)
		secondary_up.disconnect(child.on_secondary_up)
		hand.remove_child(child)
	holsters[index].add_child(Globals.create_weapon(worn_weapons[index], self))
	attacking = false

func get_closest_body(bodies: Array[Node2D]) -> Node2D:
	if bodies.size() == 1:
		return bodies[0]
	var closest = bodies[0]
	for body in bodies:
		if position.distance_to(body.position) < position.distance_to(closest.position):
			closest = body
	return closest

func on_weapon_attack() -> void:
	attacking = true
	var mouse = get_global_mouse_position()
	sprites.scale.x = 1
	if mouse.x < position.x:
		sprites.scale.x = -1
	hand.look_at(mouse)

func on_weapon_idle() -> void:
	hand.rotation_degrees = 0
	attacking = false
