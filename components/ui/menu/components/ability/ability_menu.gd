class_name AbilityMenu
extends MarginContainer

signal equipped_ability_updated(index: int, ability: Ability)

@export var ability_sets: Array[AbilitySetData]
@export var ability_component: AbilityComponent
@export var player: Player

@onready var ability_sets_container: TabContainer = $HBoxContainer/VBoxContainer/AbilitySets
@onready var ability_info_container: AbilityInfoContainer = $HBoxContainer/AbilityInfo
@onready var grabbed_ability_container: AbilityContainer = $GrabbedAbilityContainer
@onready var equipped_set_container: EquippedContainer = $HBoxContainer/VBoxContainer/EquippedSet

var ability_set_container_scene = preload ("res://features/abilities/ability_set_container/ability_set_container.tscn")

func _ready():
	if ability_sets:
		set_ability_sets(ability_sets)
	if player:
		equipped_set_container.set_equipped_set(player)

func set_ability_sets(new_ability_sets) -> void:
	for child in ability_sets_container.get_children():
		ability_sets_container.remove_child(child)
	for ability_set in new_ability_sets:
		if ability_set:
			var ability_set_container: AbilitySetContainer = ability_set_container_scene.instantiate()
			ability_set_container.name = ability_set.name
			ability_set_container.ability_clicked.connect(on_ability_clicked)
			ability_set_container.ability_hovered.connect(on_ability_hovered)
			ability_sets_container.add_child(ability_set_container)
			ability_set_container.set_data(ability_set)
			ability_set_container.set_abilities(ability_component.get_children())

func set_grabbed_container_ability(ability: Ability) -> void:
	grabbed_ability_container.set_ability(ability)
	grabbed_ability_container.visible = true if ability else false

func on_ability_hovered(ability: Ability) -> void:
	ability_info_container.set_ability(ability)

func on_ability_clicked(ability: Ability, button_index: MouseButton) -> void:
	match [button_index, ability]:
		[MOUSE_BUTTON_LEFT, _]:
			set_grabbed_container_ability(ability)
		[_, _]:
			return

func _on_equipped_set_container_hovered(ability_container: AbilityContainer):
	ability_info_container.set_ability(ability_container.ability)

func _on_equipped_set_container_clicked(button_index: MouseButton, ability_container: AbilityContainer):
	match [button_index, grabbed_ability_container.ability]:
		[MOUSE_BUTTON_LEFT, null]:
			return
		[MOUSE_BUTTON_LEFT, _]:
			if grabbed_ability_container.ability.type == ability_container.type:
				ability_container.set_ability(grabbed_ability_container.ability)
				set_grabbed_container_ability(null)
				equipped_ability_updated.emit(ability_container.get_index(), ability_container.ability)
		[MOUSE_BUTTON_RIGHT, _]:
			ability_container.set_ability(null)
			equipped_ability_updated.emit(ability_container.get_index(), ability_container.ability)
