class_name Player
extends Mob

@export_category('Player Components')
@export var state_component: StateComponent
@export var interactor_component: InteractorComponent
@export var inventory_component: InventoryComponent
@export var ability_component: AbilityComponent
@export var stamina_component: StaminaComponent
@export_category('Player Abilities')
@export var ability_1: Ability
@export var ability_2: Ability
@export var ability_3: Ability
@export var ability_4: Ability

var interactable: InteractableComponent

func _ready() -> void:
	super()
	state_component.init(self)
	stamina_component.attributes = generics

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ability_1") and ability_1 and ability_1.can_start(self):
		ability_1.start(self)
		state_component.change_state(ability_1.state)

	if Input.is_action_just_pressed("ability_2") and ability_2 and ability_2.can_start(self):
		ability_2.start(self)
		state_component.change_state(ability_2.state)

	if Input.is_action_just_pressed("ability_3") and ability_3 and ability_3.can_start(self):
		ability_3.start(self)
		state_component.change_state(ability_3.state)

	if Input.is_action_just_pressed("ability_4") and ability_4 and ability_4.can_start(self):
		ability_4.start(self)
		state_component.change_state(ability_4.state)

	if Input.is_action_just_pressed("consumable_1"):
		inventory_component.inventory.consume_slot(4, self)
	
	if Input.is_action_just_pressed("consumable_2"):
		inventory_component.inventory.consume_slot(5, self)
	
	if Input.is_action_just_pressed("interact"):
		interactor_component.interact()
	
	state_component.process_input(event)

func _process(delta: float) -> void:
	state_component.process_frame(delta)

func _physics_process(delta):
	state_component.process_physics(delta)

func _on_interactor_component_interactables_updated() -> void:
	interactable = interactor_component.get_first_interactable()

func _on_ability_menu_equipped_ability_updated(index: int, ability: Ability):
	match index:
		0:
			ability_1 = ability
		1:
			ability_2 = ability
		2:
			ability_3 = ability
		3:
			ability_4 = ability
