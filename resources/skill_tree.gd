extends Resource
class_name SkillTree

signal spent_points_changed(points: int)

@export var name: String
@export var color: Color
@export var set_a: SkillSet
@export var set_b: SkillSet
@export var set_c: SkillSet
@export var set_d: SkillSet
@export var set_e: SkillSet

var spent_points: int = 0:
	set(value):
		spent_points = value
		set_active_sets()
		spent_points_changed.emit(value)
var sets: Array[SkillSet]:
	get:
		return [set_a, set_b, set_c, set_d, set_e]


func ready() -> void:
	for set in sets:
		if not set:
			continue
		set.ready(self)


func reset(effect_component: EffectComponent = null) -> int:
	spent_points = 0
	var points = 0
	for set in sets:
		if not set:
			continue
		points += set.reset(effect_component)
	activate_set(0)
	return points


func activate_set(index: int) -> void:
	if not sets[index]:
		return
	for skill in sets[index].skills:
		if not skill:
			continue
		skill.active = true


func set_active_sets() -> void:
	match spent_points:
		5:
			activate_set(1)
		10:
			activate_set(2)
		15:
			activate_set(3)
		20:
			activate_set(4)
