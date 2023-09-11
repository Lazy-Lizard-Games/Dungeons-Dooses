extends Resource
class_name Skill

@export var name: String
@export var description: String
@export var max_stacks: int:
	set(value):
		if effect_instance:
			effect_instance.max_stacks = value
		max_stacks = value
@export var effect_instance: EffectInstance
@export var color: Color = Color.ALICE_BLUE
@export_multiline var details: Array[String]
var stacks = 0

func get_detail(index) -> String:
	if index >= details.size() or index < 0:
		return ""
	return details[index]
