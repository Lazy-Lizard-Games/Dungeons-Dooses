extends Resource
class_name SkillSet

@export var skill_a: Skill
@export var skill_b: Skill
@export var skill_c: Skill

var skills: Array[Skill]:
	get:
		return [skill_a, skill_b, skill_c]


func ready(skill_tree: SkillTree) -> void:
	for skill in skills:
		if not skill:
			continue
		skill.tree = skill_tree


func reset(effect_component: EffectComponent = null) -> int:
	var points = 0
	for skill in skills:
		if not skill:
			continue
		points += skill.stacks
		skill.stacks = 0
		skill.active = false
		if effect_component:
			for effect_instance in skill.effect_instances:
				effect_component.remove_effect(effect_instance)
	return points
