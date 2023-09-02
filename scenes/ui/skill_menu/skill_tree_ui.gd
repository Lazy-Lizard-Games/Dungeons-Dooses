extends PanelContainer
class_name SkillTreeUI

signal focus_changed(state: bool, skill: Skill)
signal slot_clicked(skill: Skill)

@export var active: bool
@onready var tree: VBoxContainer = $MarginContainer/Tree

var skill_slot = preload("res://scenes/ui/skill_menu/skill_slot.tscn")


func clear() -> void:
	var sets: Array[Node] = tree.get_children()
	for set in sets:
		for child in set.get_children():
			set.remove_child(child)


func set_tree(skill_tree: SkillTree) -> void:
	self["theme_override_styles/panel"].bg_color = skill_tree.color
	var sets: Array[Node] = tree.get_children()
	for i in range(sets.size()):
		if i >= skill_tree.SIZE:
			break
		if not skill_tree.skill_sets[i]:
			continue
		for skill in skill_tree.skill_sets[i].skills:
			if skill:
				var slot: SkillSlot = skill_slot.instantiate()
				slot.skill = skill
				slot.custom_minimum_size = Vector2(75, 75)
				sets[i].add_child(slot)
				if active:
					slot.focus_changed.connect(_on_slot_focus_changed)
					slot.slot_clicked.connect(_on_slot_clicked)
			else:
				var slot = MarginContainer.new()
				slot.custom_minimum_size = Vector2(75, 75)
				sets[i].add_child(slot)
	pivot_offset = size/2


func _on_slot_focus_changed(state: bool, skill: Skill) -> void:
	focus_changed.emit(state, skill)


func _on_slot_clicked(skill: Skill) -> void:
	slot_clicked.emit(skill)
