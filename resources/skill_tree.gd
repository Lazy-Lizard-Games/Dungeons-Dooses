extends Resource
class_name SkillTree

const SIZE = 5

@export var name: String
@export var color: Color
@export var skill_sets: Array[SkillSet] = [null, null, null, null, null] :
	set(new_sets):
		if new_sets.size() >= SIZE:
			new_sets.resize(SIZE)
		skill_sets = new_sets
