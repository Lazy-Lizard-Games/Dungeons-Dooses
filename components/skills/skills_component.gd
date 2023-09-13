extends Node
class_name SkillsComponent

@export var effect_component: EffectComponent
@export var skill_trees: Array[SkillTree]
@export var skill_points: int = 0
@export var skill_menu: SkillMenu

func clear_skills() -> void:
	for skill_tree in skill_trees:
		if not skill_tree:
			continue
		for skill_set in skill_tree.skill_sets:
			if not skill_set:
				continue
			for skill in skill_set.skills:
				if not skill:
					continue
				skill_points += skill.stacks
				skill.stacks = 0
				for effect_instance in skill.effect_instances:
					effect_component.remove_effect(effect_instance)
	skill_menu.update_ui()

func buy_skill(skill: Skill) -> bool:
	if skill_points > 0 and skill.stacks < skill.max_stacks:
		for effect_instance in skill.effect_instances:
			effect_component.add_effect(effect_instance)
		skill.stacks += 1
		skill_points -= 1
		return true
	return false
