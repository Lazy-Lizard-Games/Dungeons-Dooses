extends MarginContainer
class_name SkillMenu


@export var skills_component: SkillsComponent

@onready var active_skill_tree = $ForegroundContainer/ActiveSkillTree
@onready var skill_info_card = $ForegroundContainer/SideBar/SkillInfoCard
@onready var skill_points = $ForegroundContainer/SideBar/PanelContainer/SkillPoints
@onready var bg_tree_left = $BackgroundContainer/BgTreeLeft
@onready var bg_tree_right = $BackgroundContainer/BgTreeRight

var packed_skill_tree_ui = preload("res://scenes/ui/skill_menu/skill_tree_ui.tscn")
var active_index = 0


func _ready() -> void:
	active_skill_tree.focus_changed.connect(_on_focus_changed)
	active_skill_tree.slot_clicked.connect(_on_slot_clicked)
	set_menu(active_index)
	update_ui()


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


func update_ui() -> void:
	skill_info_card.update()
	skill_points.text = "Skill Points: %s" % skills_component.skill_points


func _on_left_pressed():
	var max = skills_component.skill_trees.size()-1
	var new_index = active_index - 1 if active_index > 0 else max
	set_menu(new_index)


func _on_right_pressed():
	var max = skills_component.skill_trees.size()-1
	var new_index = active_index + 1 if active_index < max else 0
	set_menu(new_index)


func _on_focus_changed(state: bool, skill: Skill) -> void:
	if state:
		skill_info_card.set_skill(skill)


func _on_slot_clicked(skill: Skill) -> void:
	var result = skills_component.buy_skill(skill)
	if result:
		update_ui()
