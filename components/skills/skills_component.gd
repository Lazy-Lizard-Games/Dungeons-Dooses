extends Node
class_name SkillsComponent

@export var effect_component: EffectComponent
@export var skill_trees: Array[SkillTree]
@export var skill_points: int = 0


func buy_skill(skill: Skill) -> bool:
	if skill_points > 0 and skill.stacks < skill.max_stacks:
		skill.stacks += 1
		skill_points -= 1
		return true
	return false
