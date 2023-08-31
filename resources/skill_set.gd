extends Resource
class_name SkillSet

const SIZE = 3

@export var skills: Array[Skill] = [null, null, null] :
	set(new_skills):
		if new_skills.size() >= SIZE:
			new_skills.slice(0, SIZE)
		skills = new_skills
