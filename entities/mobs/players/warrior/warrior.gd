class_name Player
extends Mob

@export_category('Player Components')
@export var state_component: StateComponent
@export var interactor_component: InteractorComponent
@export var inventory_component: InventoryComponent
@export var ability_component: AbilityComponent
@export var stamina_component: StaminaComponent
@export var animation_tree: AnimationTree
@export_category('Player Abilities')
@export var primary: Ability
@export var secondary: Ability
@export var defence: Ability
@export var support: Ability

var interactable: InteractableComponent

## Fetches the ability associated with the index, if any.
func get_ability(index: int) -> Ability:
	match index:
		0:
			return primary
		1:
			return secondary
		2:
			return defence
		3:
			return support
		_:
			return null

func set_ability(index: int, ability: Ability) -> void:
	match index:
		0:
			primary = ability
		1:
			secondary = ability
		2:
			defence = ability
		3:
			support = ability

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

func _on_ability_menu_equipped_ability_updated(index: int, ability: Ability):
	set_ability(index, ability)

func _on_ability_pressed(index: int):
	var ability = get_ability(index)
	start_ability(ability)
