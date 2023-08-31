extends PanelContainer
class_name SkillTreeUI


@export var skill_tree: SkillTree


@onready var tree: VBoxContainer = $MarginContainer/Tree


func _ready() -> void:
	update_tree(skill_tree)


func update_tree(skill_tree: SkillTree) -> void:
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
