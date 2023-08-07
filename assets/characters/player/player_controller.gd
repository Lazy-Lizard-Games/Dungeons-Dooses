extends Character

## Player's inventory data
@export var inventory_data: InventoryData
## Player's equipment data
@export var equipment_data: InventoryData
## Player's reach for interaction
@export var reach: int = 100

@onready var interactions: Node2D = $Interactions
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
signal tertiary_down
signal tertiary_up

var title = "Player"
var worn_armours: Array[ArmourData] = []
var worn_weapons: Array[Node2D] = [null, null]
var holsters: Array[Node2D]
var held_index = -1
var old_index = 0
var holstered = false
var attacking = false
var abilities: Array[AbilityData] = [null, null, null]

var rotation_scale = 1.0
var movement_scale = 1.0


func init_setup() -> void:
	Globals.add_ability(preload("res://assets/abilities/spear/triple_thrust/spear_triple_thrust.tres"))
	holsters = [holster_a, holster_b]
	equipment_data.inventory_updated.connect(on_equipment_updated)

func _unhandled_input(event: InputEvent) -> void:
# Inventory/UI related actions ----------------------------------------------- #
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
	
	if Input.is_action_just_pressed("interact"):
		interactions.interact()
	
# Gameplay related actions --------------------------------------------------- #
	
	if Input.is_action_just_pressed("weapon_A"):
		if held_index != 0:
			holstered = false
			swap_held_weapon(0)
		else:
			holstered = true
			swap_held_weapon(-1)
	
	if Input.is_action_just_pressed("weapon_B"):
		if held_index != 1:
			holstered = false
			swap_held_weapon(1)
		else:
			holstered = true
			swap_held_weapon(-1)
	
	if Input.is_action_just_pressed("holster"):
		holstered = not holstered
		if holstered:
			swap_held_weapon(-1)
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
	
	if Input.is_action_just_pressed("tertiary"):
		tertiary_down.emit()
	
	if Input.is_action_just_released("tertiary"):
		tertiary_up.emit()
	
	if Input.is_action_just_pressed("ui_left"):
		apply_force(1000, Vector2.RIGHT)
	
# ---------------------------------------------------------------------------- #

# Physics updates ------------------------------------------------------------ #
func _physics_process(delta) -> void:
	update_rotation()
	update_position()

func update_rotation() -> void:
	var mouse = get_global_mouse_position()
	if not attacking:
		sprites.scale.x = 1
		if mouse.x < position.x:
			sprites.scale.x = -1
	hand.rotate(hand.get_angle_to(mouse) * rotation_scale)

func update_position() -> void:
	var speed = get_stat("speed") * get_stat("speed_mult")
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction:
		velocity = velocity.lerp(direction * speed * movement_scale, 1)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	
	if velocity.length() > 0.1:
		animator.play("walk")
	else:
		animator.play("idle")
	move_and_slide()
# ---------------------------------------------------------------------------- #

# Equipment updates ---------------------------------------------------------- #
func on_equipment_updated(equipment_data: InventoryData) -> void:
	# Clear old equipment
	if held_index >= 0:
		swap_held_weapon(-1)
	for weapon in worn_weapons:
		if weapon:
			weapon.queue_free()
	worn_armours.clear()
	worn_weapons.clear()
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
		equip_weapon(holsters[i], weapons[i])

func equip_weapon(holster: Node2D, weapon_slot: SlotData) -> void:
	if weapon_slot:
		var weapon = Globals.create_weapon(weapon_slot.item_data, self)
		worn_weapons.append(weapon)
		holster.add_child(weapon)
	else:
		worn_weapons.append(null)

func update_stats() -> void:
	reset_stats()
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
# ---------------------------------------------------------------------------- #

# Weapon handling ------------------------------------------------------------ #
func swap_held_weapon(index: int) -> void:
	if held_index == index:
		return
	if held_index >= 0 and worn_weapons[held_index]:
		holster_weapon(held_index)
	old_index = held_index
	held_index = index
	swap_weapon.emit(held_index)
	if index >= 0 and worn_weapons[held_index]:
		hold_weapon(held_index)

func hold_weapon(index) -> void:
	var weapon = worn_weapons[index]
	connect_actions(weapon)
	weapon.reparent(hand, false)
	attacking = false

func holster_weapon(index) -> void:
	var weapon = worn_weapons[index]
	weapon.end_actions()
	disconnect_actions(weapon)
	weapon.reparent(holsters[index], false)
	attacking = false

func connect_actions(weapon) -> void:
	weapon.attack.connect(on_weapon_attack)
	weapon.idle.connect(on_weapon_idle)
	primary_down.connect(weapon.on_primary_down)
	primary_up.connect(weapon.on_primary_up)
	secondary_down.connect(weapon.on_secondary_down)
	secondary_up.connect(weapon.on_secondary_up)
	tertiary_down.connect(weapon.on_tertiary_down)
	tertiary_up.connect(weapon.on_tertiary_up)

func disconnect_actions(weapon) -> void:
	weapon.attack.disconnect(on_weapon_attack)
	weapon.idle.disconnect(on_weapon_idle)
	primary_down.disconnect(weapon.on_primary_down)
	primary_up.disconnect(weapon.on_primary_up)
	secondary_down.disconnect(weapon.on_secondary_down)
	secondary_up.disconnect(weapon.on_secondary_up)
	tertiary_down.disconnect(weapon.on_tertiary_down)
	tertiary_up.disconnect(weapon.on_tertiary_up)
# ---------------------------------------------------------------------------- #

# Player specific utility ---------------------------------------------------- #
func get_abilities() -> Array[AbilityData]:
	return abilities

func set_ability(index: int, ability: AbilityData) -> void:
	abilities[index] = ability

func get_type() -> Globals.WEAPON_TYPES:
	return Globals.WEAPON_TYPES.CHARACTER
# ---------------------------------------------------------------------------- #

# Signal reception ----------------------------------------------------------- #
func on_weapon_attack(movement_penalty: float = 0) -> void:
	attacking = true
	movement_scale -= movement_penalty
	rotation_scale = 0

func on_weapon_idle() -> void:
	hand.rotation_degrees = 0
	attacking = false
	movement_scale = 1
	rotation_scale = 1
# ---------------------------------------------------------------------------- #
