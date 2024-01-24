extends Mob

@export var state_component: StateComponent
@export var interactor_component: InteractorComponent
@export var inventory_component: InventoryComponent
@export var ability_component: AbilityComponent
@export var attack_state: State

var selected_ability = 0:
	set(s):
		selected_ability = s % 4

var interactable: InteractableComponent


func _ready() -> void:
	super()
	state_component.init(self)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			match event.button_index:
				MOUSE_BUTTON_WHEEL_DOWN:
					selected_ability += 1
					if selected_ability == 4:
						selected_ability = 0
				MOUSE_BUTTON_WHEEL_UP:
					selected_ability -= 1
					if selected_ability == -1:
						selected_ability = 3
	
	if Input.is_action_just_pressed("select_ability_1"):
		selected_ability = 0
	
	if Input.is_action_just_pressed("select_ability_2"):
		selected_ability = 1
	
	if Input.is_action_just_pressed("select_ability_3"):
		selected_ability = 2
	
	if Input.is_action_just_pressed("select_ability_4"):
		selected_ability = 3
	
	if Input.is_action_just_pressed("consumable_1"):
		inventory_component.inventory.consume_slot(4, self)
	
	if Input.is_action_just_pressed("consumable_2"):
		inventory_component.inventory.consume_slot(5, self)
	
	if Input.is_action_just_pressed("interact"):
		interactor_component.interact()
	
	if Input.is_action_just_pressed("ui_cancel"):
		$UI.toggle(self)
	
	state_component.process_input(event)


func _process(delta: float) -> void:
	state_component.process_frame(delta)


func _physics_process(delta):
	if Input.is_action_pressed("primary") and $UI/Hud.visible:
		var ability = ability_component.get_ability(selected_ability)
		if ability and !ability.is_casting and !ability.is_recharging:
			state_component.change_state(attack_state)
	state_component.process_physics(delta)


func _on_interactor_component_interactables_updated() -> void:
	interactable = interactor_component.get_first_interactable()
