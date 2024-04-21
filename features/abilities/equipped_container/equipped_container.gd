class_name EquippedContainer
extends MarginContainer

## Displays currently equipped abilities.

signal container_clicked(button_index: MouseButton, ability_container: AbilityContainer)
signal container_hovered(ability_container: AbilityContainer)

@onready var set_container = $HBoxContainer

func _ready():
	for ability_container in set_container.get_children() as Array[AbilityContainer]:
		ability_container.clicked.connect(on_ability_container_clicked.bind(ability_container))
		ability_container.hovered.connect(on_ability_container_hovered.bind(ability_container))

func set_equipped_set(player: Player) -> void:
	var ability_containers = set_container.get_children() as Array[AbilityContainer]
	ability_containers[0].set_ability(player.ability_1)
	ability_containers[1].set_ability(player.ability_2)
	ability_containers[2].set_ability(player.ability_3)
	ability_containers[3].set_ability(player.ability_4)

func on_ability_container_clicked(button_index: MouseButton, ability_container: AbilityContainer) -> void:
	container_clicked.emit(button_index, ability_container)

func on_ability_container_hovered(ability_container: AbilityContainer) -> void:
	container_hovered.emit(ability_container)