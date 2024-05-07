extends MarginContainer
class_name SkillMenu

## Skill component to render skills from.
@export var skill_component: SkillComponent
## Entity to control skill interactions.
@export var entity: Entity
## Grid container for skill slots of currently active skill tree.
@onready var active_grid_container = $HBoxContainer/CurrentSkillTree/MarginContainer/GridContainer
## Skill slot scene.
const SKILL_SLOT = preload("res://components/ui/skill_menu/skill_slot/skill_slot.tscn")
## Index of the currently active skill tree.
var active_index := 0:
	set(new_index):
		active_index = new_index
		if active_index >= skill_component.skill_trees.size():
			active_index = 0
		if active_index < 0:
			active_index = skill_component.skill_trees.size()-1

func _ready() -> void:
	update_skill_tree()


func update_skill_tree() -> void:
	for child in active_grid_container.get_children():
		child.queue_free()
	if skill_component.skill_trees.size() < active_index:
		return
	var skill_tree = skill_component.skill_trees[active_index]
	for skill in skill_tree.skills:
		var skill_slot = SKILL_SLOT.instantiate() as SkillSlot
		skill_slot.skill = skill
		skill_slot.clicked.connect(purchase_skill.bind(skill))
		active_grid_container.add_child(skill_slot)


func purchase_skill(skill: Skill) -> void:
	if skill_component.skill_points > 0:
		if skill.purchase(entity):
			skill_component.skill_points -= 1
