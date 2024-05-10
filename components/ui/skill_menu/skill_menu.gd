extends MarginContainer
class_name SkillMenu

## Skill slot scene.
const SKILL_SLOT = preload ("res://components/ui/skill_menu/skill_slot/skill_slot.tscn")

## Grid container for skill slots of currently active skill tree.
@onready var active_grid_container = $HBoxContainer/CurrentSkillTree/MarginContainer/GridContainer

var player: Player
var skill_component: SkillComponent
## Index of the currently active skill tree.
var active_index := 0:
	set(new_index):
		active_index = new_index
		if active_index >= skill_component.skill_trees.size():
			active_index = 0
		if active_index < 0:
			active_index = skill_component.skill_trees.size() - 1

func init(default_player: Player) -> void:
	player = default_player
	skill_component = player.skill_component
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
		if skill.purchase(player):
			skill_component.skill_points -= 1
