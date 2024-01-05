extends Mob
class_name Warrior

@export var state_component: StateComponent
@export var interactor_component: InteractorComponent

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
				MOUSE_BUTTON_WHEEL_UP:
					selected_ability -= 1
	
	if Input.is_action_just_pressed("select_ability_1"):
		selected_ability = 0
	
	if Input.is_action_just_pressed("select_ability_2"):
		selected_ability = 1
	
	if Input.is_action_just_pressed("select_ability_3"):
		selected_ability = 2
	
	if Input.is_action_just_pressed("select_ability_4"):
		selected_ability = 3
	
	if Input.is_action_just_pressed("interact"):
		interactor_component.interact()
		#if interactable:
			#interactable.interact(interactor_component)
	
	state_component.process_input(event)


func _process(delta: float) -> void:
	state_component.process_frame(delta)


func _physics_process(delta):
	state_component.process_physics(delta)


func _on_health_component_died(_amount: float, _wsource: Entity) -> void:
	health_component.heal(health_component.maximum.get_final_value())


func _on_interactor_component_interactables_updated() -> void:
	interactable = interactor_component.get_first_interactable()
