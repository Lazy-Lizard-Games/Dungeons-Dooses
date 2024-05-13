class_name AbilitiesContainer
extends Panel

## Keeps abilities in one neat spot for ease of use.

signal ability_hovered(ability: Ability)
signal ability_clicked(button_index: MouseButton, ability: Ability)

@onready var primary_row = get_node("RowContainer/PrimaryRow")
@onready var secondary_row = get_node("RowContainer/SecondaryRow")
@onready var support_row = get_node("RowContainer/SupportRow")
@onready var passive_row = get_node("RowContainer/PassiveRow")

var ability_container_scene = preload ("res://features/abilities/ability_container/ability_container.tscn")

func clear_abilities() -> void:
	queue_free_children(primary_row)
	queue_free_children(secondary_row)
	queue_free_children(support_row)
	queue_free_children(passive_row)

func add_ability(ability: Ability) -> void:
	var ability_container: AbilityContainer = ability_container_scene.instantiate()
	ability_container.set_ability(ability)
	ability_container.hovered.connect(_on_ability_container_hovered.bind(ability))
	ability_container.clicked.connect(_on_ability_container_clicked.bind(ability))
	match ability.type:
		Enums.AbilityType.Primary:
			primary_row.add_child(ability_container)
		Enums.AbilityType.Secondary:
			secondary_row.add_child(ability_container)
		Enums.AbilityType.Support:
			support_row.add_child(ability_container)
		Enums.AbilityType.Passive:
			passive_row.add_child(ability_container)

func queue_free_children(node: Node) -> void:
	for idx in node.get_child_count():
		node.get_child(idx).queue_free()

func _on_ability_container_hovered(ability: Ability) -> void:
	ability_hovered.emit(ability)

func _on_ability_container_clicked(button_index: MouseButton, ability: Ability) -> void:
	ability_clicked.emit(button_index, ability)