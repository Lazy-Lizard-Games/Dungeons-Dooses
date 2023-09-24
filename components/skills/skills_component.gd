extends Node
class_name SkillsComponent

signal skills_cleared

@export var effect_component: EffectComponent
@export var skill_trees: Array[SkillTree]
@export var skill_points: int = 0


func _ready() -> void:
	for skill_tree in skill_trees:
		if not skill_tree:
			continue
		skill_tree.ready()


func reset() -> void:
	for skill_tree in skill_trees:
		if not skill_tree:
			continue
		skill_points += skill_tree.reset(effect_component)
	skills_cleared.emit()

func buy_skill(skill: Skill) -> bool:
	if skill_points > 0 and skill.stacks < skill.max_stacks:
		for effect_instance in skill.effect_instances:
			effect_component.add_effect(effect_instance)
		skill.stacks += 1
		skill.tree.spent_points += 1
		skill_points -= 1
		return true
	return false
