extends VBoxContainer
class_name SkillTreeUI

signal focus_changed(state: bool, skill: Skill)
signal slot_clicked(skill: Skill)

@export var active: bool

@onready var overlay = $TreeContainer/Overlay
@onready var tree = $TreeContainer/Tree

var skill_slot = preload("res://scenes/ui/skill_menu/skill_slot.tscn")
var points: int = 0


func _ready() -> void:
	resized.connect(on_resized)


func clear() -> void:
	var sets: Array[Node] = tree.get_children()
	for set in sets:
		for child in set.get_children():
			set.remove_child(child)


func set_tree(skill_tree: SkillTree) -> void:
	var sets: Array[Node] = tree.get_children()
	for i in range(sets.size()):
		if not skill_tree.sets[i]:
			continue
		for skill in skill_tree.sets[i].skills:
			add_slot(skill, sets[i])
	pivot_offset = size/2
	skill_tree.spent_points_changed.connect(on_spent_points_changed)


func add_slot(skill: Skill, set: Node) -> void:
	var slot: SkillSlot = skill_slot.instantiate()
	slot.skill = skill
	set.add_child(slot)
	if active and skill:
		slot.focus_changed.connect(_on_slot_focus_changed)
		slot.slot_clicked.connect(_on_slot_clicked)


func set_progress_overlay() -> void:
	overlay.custom_minimum_size.y = min(points, 25) * (tree.size.y / 25.0)


func _on_slot_focus_changed(state: bool, skill: Skill) -> void:
	focus_changed.emit(state, skill)


func _on_slot_clicked(skill: Skill) -> void:
	slot_clicked.emit(skill)


func on_spent_points_changed(points_in: int) -> void:
	points = points_in
	set_progress_overlay()

func on_resized() -> void:
	set_progress_overlay()
	for set in tree.get_children():
		for slot in set.get_children():
			slot.resize()
