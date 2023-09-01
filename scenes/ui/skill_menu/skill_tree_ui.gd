extends PanelContainer
class_name SkillTreeUI


@export var active: bool
@onready var tree: VBoxContainer = $MarginContainer/Tree


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
			var rect
			if skill:
				rect = ColorRect.new()
				rect.color = Color.WHITE
			else:
				rect = MarginContainer.new()
			rect.custom_minimum_size = Vector2(75, 75)
			sets[i].add_child(rect)
	pivot_offset = size/2
