extends MarginContainer
class_name SkillMenu


@export var skills_component: SkillsComponent

@onready var active_skill_tree = $ForegroundContainer/ActiveSkillTree
@onready var bg_tree_left = $BackgroundContainer/BgTreeLeft
@onready var bg_tree_right = $BackgroundContainer/BgTreeRight

var packed_skill_tree_ui = preload("res://scenes/ui/skill_menu/skill_tree_ui.tscn")
var active_index = 0


func _ready() -> void:
	set_menu(active_index)


func set_menu(index: int) -> void:
	active_index = index
	set_background(index)
	set_foreground(index)


func set_foreground(index: int) -> void:
	var tree: SkillTree = skills_component.skill_trees[index]
	active_skill_tree.clear()
	if tree:
		active_skill_tree.set_tree(tree)


func set_background(index: int) -> void:
	var max_index = skills_component.skill_trees.size()-1
	var left_index: int = index - 1 if index > 0 else max_index
	var right_index: int = index + 1 if index < max_index else 0
	var tree_left: SkillTree = skills_component.skill_trees[left_index]
	var tree_right: SkillTree = skills_component.skill_trees[right_index]
	bg_tree_left.clear()
	if tree_left:
		bg_tree_left.set_tree(tree_left)
	bg_tree_right.clear()
	if tree_right:
		bg_tree_right.set_tree(tree_right)


func _on_left_pressed():
	var max = skills_component.skill_trees.size()-1
	var new_index = active_index - 1 if active_index > 0 else max
	set_menu(new_index)


func _on_right_pressed():
	var max = skills_component.skill_trees.size()-1
	var new_index = active_index + 1 if active_index < max else 0
	set_menu(new_index)
