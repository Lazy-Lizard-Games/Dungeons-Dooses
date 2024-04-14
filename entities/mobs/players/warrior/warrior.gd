extends Mob
class_name Player

@export_category('Player Components')
@export var state_component: StateComponent
@export var interactor_component: InteractorComponent
@export var inventory_component: InventoryComponent
@export var ability_component: AbilityComponent
@export var stamina_component: StaminaComponent
@export_category('Player Abilities')
@export var ability_1_index: int
@export var ability_2_index: int
@export var ability_3_index: int
@export var ability_4_index: int

var selected_ability_index = 0:
	set(s):
		selected_ability_index = s % 4

var interactable: InteractableComponent

func _ready() -> void:
	super()
	state_component.init(self)
	stamina_component.attributes = generics
	ability_1_index = 0
	ability_2_index = 1
	ability_3_index = 2
	ability_4_index = 3

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			match event.button_index:
				MOUSE_BUTTON_WHEEL_DOWN:
					selected_ability_index += 1
					if selected_ability_index == 4:
						selected_ability_index = 0
				MOUSE_BUTTON_WHEEL_UP:
					selected_ability_index -= 1
					if selected_ability_index == - 1:
						selected_ability_index = 3
	
	if Input.is_action_just_pressed("select_ability_1"):
		selected_ability_index = 0
	
	if Input.is_action_just_pressed("select_ability_2"):
		selected_ability_index = 1
	
	if Input.is_action_just_pressed("select_ability_3"):
		selected_ability_index = 2
	
	if Input.is_action_just_pressed("select_ability_4"):
		selected_ability_index = 3
	
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

func get_selected_ability_index() -> int:
	match selected_ability_index:
		0: return ability_1_index
		1: return ability_2_index
		2: return ability_3_index
		3: return ability_4_index
		_: return - 1
