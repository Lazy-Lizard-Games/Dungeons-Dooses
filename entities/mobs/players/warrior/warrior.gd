class_name Player
extends Mob

@export_category('Player Components')
@export var state_component: StateComponent
@export var interactor_component: InteractorComponent
@export var inventory_component: InventoryComponent
@export var ability_component: AbilityComponent
@export var stamina_component: StaminaComponent
@export var skill_component: SkillComponent
@export var animation_tree: AnimationTree
@export_category('Player Abilities')
@export var primary: int = -1
@export var secondary: int = -1
@export var support: int = -1
@export var passive: int = -1

var interactable: InteractableComponent

func equip_ability(type: Enums.AbilityType, ability_index: int) -> void:
	match type:
		Enums.AbilityType.Primary:
			primary = ability_index
		Enums.AbilityType.Secondary:
			secondary = ability_index
		Enums.AbilityType.Support:
			support = ability_index
		Enums.AbilityType.Passive:
			passive = ability_index

func start_ability(ability: Ability) -> void:
	if ability:
		if ability.state == Enums.AbilityState.Ready:
			if stamina_component.current > (ability.cost * stats_component.ability_efficiency.get_final_value()):
				state_component.change_state(ability)
				return
		ability.failed.emit()

func _ready() -> void:
	state_component.init()

func _unhandled_input(event: InputEvent) -> void:
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

func _on_ability_pressed(type: Enums.AbilityType):
	match type:
		Enums.AbilityType.Primary:
			ability_component.start(primary)
		Enums.AbilityType.Secondary:
			ability_component.start(secondary)
		Enums.AbilityType.Support:
			ability_component.start(support)
