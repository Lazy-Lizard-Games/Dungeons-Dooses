extends MarginContainer
class_name SkillMenu


@export var skills_component: SkillsComponent

@onready var trees_container: HBoxContainer = $TreesContainer

var packed_skill_tree_ui = preload("res://scenes/ui/skill_menu/skill_tree_ui.tscn")


func _ready() -> void:
	for skill_tree in skills_component.skill_trees:
		if not skill_tree:
			continue
		var skill_tree_ui: SkillTreeUI = packed_skill_tree_ui.instantiate()
		skill_tree_ui.skill_tree = skill_tree
		trees_container.add_child(skill_tree_ui)
