extends MarginContainer
class_name SkillMenu


@export var skills_component: SkillsComponent

@onready var active_skill_tree = $ForegroundContainer/TreeContainer/ActiveSkillTree
@onready var skill_points = $ForegroundContainer/SideBar/PanelContainer/SkillPoints
@onready var skill_info_card = $ForegroundContainer/SideBar/SkillInfoCard

var packed_skill_tree_ui = preload("res://scenes/ui/skill_menu/skill_tree_ui.tscn")
var active_index = 0


func _ready() -> void:
	skills_component.skills_cleared.connect(update_ui)
	active_skill_tree.focus_changed.connect(_on_focus_changed)
	active_skill_tree.slot_clicked.connect(_on_slot_clicked)
	set_menu(active_index)
	update_ui()
	skills_component.reset()


func set_menu(index: int) -> void:
	active_index = index
	set_foreground(index)


func set_foreground(index: int) -> void:
	var tree: SkillTree = skills_component.skill_trees[index]
	active_skill_tree.clear()
	if tree:
		active_skill_tree.set_tree(tree)


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
