class_name AbilityMenu
extends MarginContainer

@export var ability_sets: Array[AbilitySetData]

@onready var ability_sets_container: TabContainer = $HBoxContainer/AbilitySets
@onready var ability_info_container: AbilityInfoContainer = $HBoxContainer/AbilityInfo

var ability_set_container_scene = preload ("res://features/abilities/ability_set_container/ability_set_container.tscn")

func _ready():
	if ability_sets:
		set_ability_sets(ability_sets)

func set_ability_sets(new_ability_sets) -> void:
	for child in ability_sets_container.get_children():
		ability_sets_container.remove_child(child)
	for ability_set in new_ability_sets:
		if ability_set:
			var ability_set_container: AbilitySetContainer = ability_set_container_scene.instantiate()
			ability_set_container.ability_clicked.connect(on_ability_clicked)
			ability_set_container.ability_hovered.connect(on_ability_hovered)
			ability_sets_container.add_child(ability_set_container)
			ability_set_container.set_data(ability_set)

func on_ability_clicked(ability: AbilityData, button: MouseButton) -> void:
	print(ability.name, ' clicked by ', button)

func on_ability_hovered(ability: AbilityData) -> void:
	ability_info_container.set_ability(ability)
