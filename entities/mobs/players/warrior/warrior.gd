class_name Player
extends Mob

@export var target: TargetComponent
@export_category('Player Components')
@export var interactor_component: InteractorComponent
@export var inventory_component: InventoryComponent
@export var skill_component: SkillComponent
@export_category('Player Abilities')
@export var abilities: AbilitySet
@export var loadout: AbilityLoadout

var interactable: InteractableComponent

func _ready() -> void:
	_on_loudout_loudout_updated(loadout)
	loadout.loadout_updated.connect(_on_loudout_loudout_updated)
	state_component.init()

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
	
	state_component.process_input(event)

func _process(delta: float) -> void:
	ability_component.process_ability_timers(delta)
	state_component.process_frame(delta)

func _physics_process(delta):
	state_component.process_physics(delta)

func _on_interactor_component_interactables_updated() -> void:
	interactable = interactor_component.get_first_interactable()

func _on_loudout_loudout_updated(loudout: AbilityLoadout) -> void:
	for child in ability_component.get_children():
		child.queue_free()
	if loudout.primary:
		var primary_ability = loudout.primary.ability.instantiate()
		ability_component.add_child(primary_ability)
		ability_component.set_ability(0, primary_ability)
	if loudout.secondary:
		var secondary_ability = loudout.secondary.ability.instantiate()
		ability_component.add_child(secondary_ability)
		ability_component.set_ability(1, secondary_ability)
	if loudout.support:
		var support_ability = loudout.support.ability.instantiate()
		ability_component.add_child(support_ability)
		ability_component.set_ability(2, support_ability)
	if loudout.passive:
		var passive_ability = loudout.passive.ability.instantiate()
		ability_component.add_child(passive_ability)
		ability_component.set_ability(3, passive_ability)
