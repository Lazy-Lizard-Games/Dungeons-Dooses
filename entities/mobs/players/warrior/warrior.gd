class_name Player
extends Mob

@export var target: TargetComponent
@export_category('Player Components')
@export var interactor_component: InteractorComponent
@export var inventory_component: InventoryComponent
@export var skill_component: SkillComponent
@export var sprite: Sprite2D
@export_category('Player Abilities')
@export var primary: int
@export var secondary: int
@export var support: int
@export var passive: int

var interactable: InteractableComponent
var passive_ability: Ability

func set_passive_ability(index: int) -> void:
	var ability = ability_component.get_ability(index)
	if passive_ability:
		passive_ability.exit()
	passive_ability = ability
	if passive_ability:
		passive_ability.enter()

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
			set_passive_ability(passive)

func _ready() -> void:
	state_component.init()
	set_passive_ability(passive)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("consumable_1"):
		inventory_component.inventory.consume_slot(4, self)
	
	if Input.is_action_just_pressed("consumable_2"):
		inventory_component.inventory.consume_slot(5, self)
	
	if Input.is_action_just_pressed("interact"):
		interactor_component.interact()

	if Input.is_action_just_pressed("ui_up"):
		set_elevation(elevation + 1)
	
	if Input.is_action_just_pressed("ui_down"):
		set_elevation(elevation - 1)
	
	if passive_ability:
		passive_ability.process_input(event)
	state_component.process_input(event)

func _process(delta: float) -> void:
	ability_component.process_ability_timers(delta)
	state_component.process_frame(delta)

func _physics_process(delta):
	if passive_ability:
		passive_ability.process_physics(delta)
	state_component.process_physics(delta)

func _on_interactor_component_interactables_updated() -> void:
	interactable = interactor_component.get_first_interactable()

func _on_ability_pressed(type: Enums.AbilityType):
	match type:
		Enums.AbilityType.Primary:
			ability_component.start_ability(primary)
		Enums.AbilityType.Secondary:
			ability_component.start_ability(secondary)
		Enums.AbilityType.Support:
			ability_component.start_ability(support)

